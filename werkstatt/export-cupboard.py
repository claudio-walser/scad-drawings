#!/usr/bin/env python3
"""Export the parts list (CSV) and construction drawings (SVG/PDF) of a cabinet
built with cupboard-library.scad.

Usage:
    ./export-cupboard.py lowboard.scad [cupboard.scad ...]

Writes next to each .scad file:
    <name>.csv          parts list
    <name>-plan-1.svg   views and sections with dimensions
    <name>-plan-2.svg   parts list, drawer box details and building notes
    <name>-plan.pdf     both sheets (needs inkscape and pdfunite)

OpenSCAD is taken from PATH, or from the Flatpak org.openscad.OpenSCAD.
The .scad file must call cupboard() and partsList(); the script sets
exportData=true so that the library echoes every part as a box.
"""

import argparse
import datetime
import json
import re
import shutil
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path
from xml.sax.saxutils import escape

SHEET_W, SHEET_H = 420, 297          # A3 landscape, in mm
FRAME = 10                           # frame distance to the sheet edge
TITLE_W, TITLE_H = 180, 30           # title block in the lower right corner
AREA_X0, AREA_Y0 = FRAME + 5, FRAME + 5
AREA_X1, AREA_Y1 = SHEET_W - FRAME - 5, SHEET_H - FRAME - TITLE_H - 5
SCALES = [2, 2.5, 5, 10, 15, 20, 25, 50]   # 1:n, largest drawing first
FONT = "DejaVu Sans, Arial, Helvetica, sans-serif"
FS = 2.5                             # dimension text size
LEVEL = 8.0                          # distance between dimension lines
GAP = 1.5                            # gap between object and extension line
TITLE_SPACE = 7.0                    # room for the view title
VIEW_GAP = 12.0                      # space between views
EPS = 1e-6

FILL = {
    "drawerSide": "#eaf4ea", "drawerFrontBack": "#eaf4ea", "drawerFloor": "#f3e9f5",
}
DRAWER_TYPES = ("drawerSide", "drawerFrontBack", "drawerFloor")


# ---------------------------------------------------------------- OpenSCAD

@dataclass
class Box:
    type: str
    name: str
    c: int
    i: int
    pos: list
    size: list
    color: str = None

    @property
    def x0(self): return self.pos[0]
    @property
    def x1(self): return self.pos[0] + self.size[0]
    @property
    def y0(self): return self.pos[1]
    @property
    def y1(self): return self.pos[1] + self.size[1]
    @property
    def z0(self): return self.pos[2]
    @property
    def z1(self): return self.pos[2] + self.size[2]


def openscad_command():
    if shutil.which("openscad"):
        return ["openscad"]
    if shutil.which("flatpak") and subprocess.run(
            ["flatpak", "info", "org.openscad.OpenSCAD"], capture_output=True).returncode == 0:
        return ["flatpak", "run", "org.openscad.OpenSCAD"]
    sys.exit("OpenSCAD nicht gefunden (weder im PATH noch als Flatpak)")


def parse_value(text):
    # OpenSCAD echoes vectors in a JSON compatible form, except for undef
    return json.loads(re.sub(r"\bundef\b", "null", text))


def load(scad):
    cmd = openscad_command() + ["-D", "exportData=true", "-o", "-", "--export-format", "echo", scad.name]
    result = subprocess.run(cmd, cwd=scad.parent, capture_output=True, text=True)
    problems = [l for l in result.stderr.splitlines() if l.startswith(("WARNING", "ERROR"))]
    for p in problems:
        print(f"{scad.name}: {p}", file=sys.stderr)
    if result.returncode != 0 or any(p.startswith("ERROR") for p in problems):
        sys.exit(f"{scad.name}: OpenSCAD ist fehlgeschlagen")

    info, boxes, csv_lines = None, [], []
    for line in result.stdout.splitlines():
        if line.startswith("ECHO: cupboardInfo = "):
            info = dict(parse_value(line.split(" = ", 1)[1]))
        elif line.startswith("ECHO: box = "):
            boxes.append(Box(*parse_value(line.split(" = ", 1)[1])))
        elif line.startswith('ECHO: "'):
            text = json.loads(line[6:])
            if text.startswith("Pos;") or (csv_lines and not csv_lines[-1].startswith(";Total")):
                csv_lines.append(text)
    if info is None or not boxes:
        sys.exit(f"{scad.name}: keine Daten gefunden, ruft die Datei cupboard() auf?")
    if not csv_lines:
        sys.exit(f"{scad.name}: keine Stückliste gefunden, ruft die Datei partsList() auf?")
    return info, boxes, csv_lines


# ---------------------------------------------------------------- helpers

def fmt(value):
    value = round(value, 1)
    return str(int(round(value))) if abs(value - round(value)) < 0.05 else f"{value:.1f}"


def part_key(name, dims):
    return name, tuple(sorted(round(float(d), 1) for d in dims))


def text_width(text, size):
    return len(text) * size * 0.6


class Svg:
    def __init__(self):
        self.items = []

    def line(self, x1, y1, x2, y2, width=0.25, dash=None):
        d = f' stroke-dasharray="{dash}"' if dash else ""
        self.items.append(f'<line x1="{x1:.2f}" y1="{y1:.2f}" x2="{x2:.2f}" y2="{y2:.2f}" '
                          f'stroke="#000" stroke-width="{width}"{d}/>')

    def rect(self, x, y, w, h, fill="none", width=0.35):
        self.items.append(f'<rect x="{x:.2f}" y="{y:.2f}" width="{w:.2f}" height="{h:.2f}" '
                          f'fill="{fill}" stroke="#000" stroke-width="{width}"/>')

    def blank(self, x, y, w, h):
        self.items.append(f'<rect x="{x:.2f}" y="{y:.2f}" width="{w:.2f}" height="{h:.2f}" fill="#fff" fill-opacity="0.85"/>')

    def text(self, x, y, text, size=FS, anchor="middle", rotate=0, bold=False):
        r = f' transform="rotate({rotate} {x:.2f} {y:.2f})"' if rotate else ""
        b = ' font-weight="bold"' if bold else ""
        self.items.append(f'<text x="{x:.2f}" y="{y:.2f}" font-size="{size}" text-anchor="{anchor}" '
                          f'font-family="{FONT}"{b}{r}>{escape(text)}</text>')

    def save(self, path):
        path.write_text(
            f'<?xml version="1.0" encoding="UTF-8"?>\n'
            f'<svg xmlns="http://www.w3.org/2000/svg" width="{SHEET_W}mm" height="{SHEET_H}mm" '
            f'viewBox="0 0 {SHEET_W} {SHEET_H}">\n'
            '<defs><pattern id="hatch" patternUnits="userSpaceOnUse" width="1.6" height="1.6" '
            'patternTransform="rotate(45)"><rect width="1.6" height="1.6" fill="#e4e4e4"/>'
            '<line x1="0" y1="0" x2="0" y2="1.6" stroke="#666" stroke-width="0.25"/></pattern></defs>\n'
            f'<rect width="{SHEET_W}" height="{SHEET_H}" fill="#fff"/>\n'
            + "\n".join(self.items) + "\n</svg>\n", encoding="utf-8")


# ---------------------------------------------------------------- views

def project(box, axis):
    """Return (u range, v range, depth range) of a box; depth grows away from the viewer."""
    if axis == "front":   # looking at the front, x to the right
        return (box.x0, box.x1), (box.z0, box.z1), (box.y0, box.y1)
    if axis == "right":   # looking from the right side, front on the left
        return (box.y0, box.y1), (box.z0, box.z1), (-box.x1, -box.x0)
    if axis == "top":     # looking down, front at the bottom
        return (box.x0, box.x1), (box.y0, box.y1), (-box.z1, -box.z0)
    raise ValueError(axis)


@dataclass
class Rect:
    u0: float
    u1: float
    v0: float
    v1: float
    near: float
    cut: bool
    box: Box


class View:
    """Orthographic view or section of axis-aligned boxes, drawn back to front."""

    def __init__(self, title, boxes, axis, cut=None):
        self.title = title
        self.rects = []
        for b in boxes:
            (u0, u1), (v0, v1), (d0, d1) = project(b, axis)
            near, is_cut = d0, False
            if cut is not None:
                if d1 <= cut + EPS:
                    continue
                if d0 < cut - EPS:
                    near, is_cut = cut, True
            self.rects.append(Rect(u0, u1, v0, v1, near, is_cut, b))
        # far parts first; a floor in its groove is drawn over the cut drawer walls
        self.rects.sort(key=lambda r: (-r.near, r.box.type == "drawerFloor"))
        self.umin = min(r.u0 for r in self.rects)
        self.umax = max(r.u1 for r in self.rects)
        self.vmin = min(r.v0 for r in self.rects)
        self.vmax = max(r.v1 for r in self.rects)
        self.dims, self.labels, self.marks = [], [], []
        self.ground = None

    def set_ground(self, v):
        self.ground = v
        self.vmin = min(self.vmin, v)

    def dim(self, side, level, values):
        values = sorted(set(round(v, 3) for v in values))
        if len(values) > 1:
            self.dims.append((side, level, values))

    def label(self, u0, u1, v0, v1, lines):
        self.labels.append((u0, u1, v0, v1, lines))

    def mark(self, orientation, value, letter):
        self.marks.append((orientation, value, letter))

    def margin(self, side):
        levels = max([lvl for s, lvl, _ in self.dims if s == side], default=0)
        m = levels * LEVEL + (4 if levels else 0)
        if any((o == "v" and side == "top") or (o == "h" and side == "left") for o, _, _ in self.marks):
            m = max(m, 6)
        if side == "top":
            m += TITLE_SPACE
        return m + 2

    def size(self, k):
        return ((self.umax - self.umin) * k + self.margin("left") + self.margin("right"),
                (self.vmax - self.vmin) * k + self.margin("top") + self.margin("bottom"))

    # -- drawing

    def render(self, svg, px, py, k):
        ox, oy = px + self.margin("left"), py + self.margin("top")
        X = lambda u: ox + (u - self.umin) * k
        Y = lambda v: oy + (self.vmax - v) * k

        svg.text(px, py + 4.5, self.title, size=3.5, anchor="start", bold=True)

        for r in self.rects:
            fill = "url(#hatch)" if r.cut else FILL.get(r.box.type, "#fff")
            svg.rect(X(r.u0), Y(r.v1), (r.u1 - r.u0) * k, (r.v1 - r.v0) * k, fill, 0.5 if r.cut else 0.3)

        if self.ground is not None:
            svg.line(X(self.umin) - 4, Y(self.ground), X(self.umax) + 4, Y(self.ground), 0.25, "3 1.5")
            svg.text(X(self.umax) + 4, Y(self.ground) - 1, "Boden", size=2, anchor="end")

        for orientation, value, letter in self.marks:
            if orientation == "v":
                x = X(value)
                svg.line(x, Y(self.vmax) - 5, x, Y(self.vmin) + 5, 0.35, "5 1.2 1 1.2")
                svg.text(x + 1.2, Y(self.vmax) - 2.5, letter, size=3.5, anchor="start", bold=True)
            else:
                y = Y(value)
                svg.line(X(self.umin) - 5, y, X(self.umax) + 5, y, 0.35, "5 1.2 1 1.2")
                svg.text(X(self.umin) - 5, y - 1.2, letter, size=3.5, anchor="start", bold=True)

        for u0, u1, v0, v1, lines in self.labels:
            self._render_label(svg, X(u0), X(u1), Y(v1), Y(v0), lines)

        for side, level, values in self.dims:
            if side in ("top", "bottom"):
                edge = Y(self.vmax) if side == "top" else Y(self.vmin)
                self._render_dim(svg, [X(v) for v in values], values, edge, -1 if side == "top" else 1, level, True)
            else:
                edge = X(self.umin) if side == "left" else X(self.umax)
                self._render_dim(svg, [Y(v) for v in values], values, edge, -1 if side == "left" else 1, level, False)

    @staticmethod
    def _render_label(svg, x0, x1, y0, y1, lines):
        size, step = 2.2, 2.9
        for candidate in (lines, lines[-1:]):
            fits_w = max(text_width(t, size) for t in candidate) <= (x1 - x0) - 1.5
            fits_h = len(candidate) * step <= (y1 - y0) - 1
            if fits_w and fits_h:
                top = (y0 + y1) / 2 - (len(candidate) - 1) * step / 2 + size * 0.35
                tw = max(text_width(t, size) for t in candidate)
                svg.blank((x0 + x1 - tw) / 2 - 0.5, top - size, tw + 1, len(candidate) * step + 0.3)
                for n, t in enumerate(candidate):
                    svg.text((x0 + x1) / 2, top + n * step, t, size=size)
                return

    @staticmethod
    def _render_dim(svg, positions, values, edge, sign, level, horizontal):
        """Chain dimension. positions are paper coordinates along the line,
        edge is the object edge, sign points away from the object."""
        line = edge + sign * level * LEVEL
        if horizontal:
            seg = lambda a, b, w=0.18: svg.line(a[0], a[1], b[0], b[1], w)
            pt = lambda along, across: (along, across)
        else:
            seg = lambda a, b, w=0.18: svg.line(a[0], a[1], b[0], b[1], w)
            pt = lambda along, across: (across, along)

        order = sorted(range(len(positions)), key=lambda n: positions[n])
        positions = [positions[n] for n in order]
        values = [values[n] for n in order]
        for p in positions:
            seg(pt(p, edge + sign * GAP), pt(p, line + sign * 1.5))
            a, b = pt(p - 1, line + 1), pt(p + 1, line - 1)
            svg.line(a[0], a[1], b[0], b[1], 0.35)
        seg(pt(positions[0] - 1.5, line), pt(positions[-1] + 1.5, line))

        # text rows: 0 above the line, 1 and 2 below it; a text goes to the first
        # row where it does not overlap an earlier one
        offsets = [-0.8, FS + 0.3, 2 * FS + 0.8]
        placed = {row: [] for row in range(len(offsets))}
        for n in range(len(positions) - 1):
            text = fmt(abs(values[n + 1] - values[n]))
            tw = text_width(text, FS)
            a, b = positions[n], positions[n + 1]
            if tw + 1 <= b - a:
                center = (a + b) / 2
            elif n == 0:
                center = a - 1.5 - tw / 2
            else:
                center = b + 1.5 + tw / 2
            interval = (center - tw / 2 - 0.5, center + tw / 2 + 0.5)
            row = next((r for r in placed if not any(i[0] < interval[1] and interval[0] < i[1] for i in placed[r])),
                       len(offsets) - 1)
            placed[row].append(interval)
            if horizontal:
                svg.text(center, line + offsets[row], text)
            else:
                svg.text(line + offsets[row], center, text, rotate=-90)


def fit_layout(options, width, height):
    """Find the largest scale at which one of the row layouts fits the area."""
    for n in SCALES:
        k = 1 / n
        for rows in options:
            row_w = [sum(v.size(k)[0] for v in row) + VIEW_GAP * (len(row) - 1) for row in rows]
            row_h = [max(v.size(k)[1] for v in row) for row in rows]
            if max(row_w) <= width and sum(row_h) + VIEW_GAP * (len(rows) - 1) <= height:
                return n, rows
    return SCALES[-1], options[0]


def place_rows(svg, rows, n, x0, y0):
    k = 1 / n
    y = y0
    for row in rows:
        x = x0
        for view in row:
            view.render(svg, x, y, k)
            x += view.size(k)[0] + VIEW_GAP
        y += max(v.size(k)[1] for v in row) + VIEW_GAP


def frame_and_title(svg, name, scale, sheet, info, boxes):
    svg.rect(FRAME, FRAME, SHEET_W - 2 * FRAME, SHEET_H - 2 * FRAME, width=0.5)
    x0, y0 = SHEET_W - FRAME - TITLE_W, SHEET_H - FRAME - TITLE_H
    svg.rect(x0, y0, TITLE_W, TITLE_H, width=0.5)
    svg.line(x0, y0 + 12, x0 + TITLE_W, y0 + 12, 0.25)
    svg.line(x0, y0 + 21, x0 + TITLE_W, y0 + 21, 0.25)
    for x in (60, 120):
        svg.line(x0 + x, y0 + 12, x0 + x, y0 + TITLE_H, 0.25)
    svg.text(x0 + 3, y0 + 8.5, name, size=6, anchor="start", bold=True)

    depth = max(b.y1 for b in boxes) - min(b.y0 for b in boxes)
    cells = [
        (0, 12, "Massstab", scale), (60, 12, "Blatt", sheet),
        (120, 12, "Datum", datetime.date.today().strftime("%d.%m.%Y")),
        (0, 21, "Aussenmasse B × T × H", f"{fmt(info['width'])} × {fmt(depth)} × {fmt(info['height'])}"),
        (60, 21, "Material", f"{info['material']} {fmt(info['thickness'])} mm"),
        (120, 21, "Masse", "mm"),
    ]
    for dx, dy, title, value in cells:
        svg.text(x0 + dx + 2, y0 + dy + 3, title, size=2, anchor="start")
        svg.text(x0 + dx + 2, y0 + dy + 7.5, value, size=3.2, anchor="start")


# ---------------------------------------------------------------- sheet 1

def drawers_of(boxes, c):
    """Drawer boxes of compartment c as {unit: [boxes]}."""
    result = {}
    for b in boxes:
        if b.type in DRAWER_TYPES and b.c == c:
            result.setdefault(b.i, []).append(b)
    return result


def sheet_views(info, boxes, pos_of):
    t = info["thickness"]
    width, depth, corpus_h = info["width"], info["depth"], info["corpusHeight"]
    wheel = info["wheelHeight"]
    comps = info["compartments"]   # [x, clear width, small, large, doors]
    fronts = [b for b in boxes if b.type in ("front", "door")]

    drawer_comps = [c for c, comp in enumerate(comps) if comp[2] + comp[3] > 0]
    section_c = drawer_comps[0] if drawer_comps else 0
    cx, cw = comps[section_c][0], comps[section_c][1]
    section_x = cx + cw / 2
    drawers = drawers_of(boxes, section_c)
    if drawers:
        top_drawer = max((min(b.z0 for b in parts), max(b.z1 for b in parts)) for parts in drawers.values())
        section_z = (top_drawer[0] + top_drawer[1]) / 2
    else:
        section_z = corpus_h / 2

    # A: front view
    a = View("Vorderansicht", boxes, "front")
    a.dim("top", 1, [0, width] + [v for f in fronts for v in (f.x0, f.x1)])
    a.dim("bottom", 1, [0, width])
    configs = []   # distinct drawer layouts, each dimensioned once
    for c, comp in enumerate(comps):
        key = (comp[2], comp[3], comp[4])
        if key not in [k for k, _ in configs]:
            configs.append((key, c))
    for (key, c), side in zip(configs[:2], ("left", "right")):
        zs = [v for f in fronts if f.c == c for v in (f.z0, f.z1)]
        if zs:
            a.dim(side, 1, [0, corpus_h] + zs)
    right_level = 2 if len(configs) > 1 else 1
    if wheel > 0:
        a.set_ground(-wheel)
        a.dim("right", right_level, [-wheel, 0, corpus_h])
        a.dim("right", right_level + 1, [-wheel, corpus_h])
    else:
        a.dim("right", right_level, [0, corpus_h])
    for f in fronts:
        pos = pos_of.get(part_key(f.name, f.size))
        a.label(f.x0, f.x1, f.z0, f.z1, [f"Pos {pos}" if pos else "", f"{fmt(f.size[0])} × {fmt(f.size[2])}"])

    # B: front view without fronts
    b = View("Vorderansicht ohne Fronten", [x for x in boxes if x.type not in ("front", "door")], "front")
    b.dim("bottom", 1, [0, width] + [v for comp in comps for v in (comp[0], comp[0] + comp[1])])
    for c, comp in enumerate(comps):
        for unit, parts in drawers_of(boxes, c).items():
            x0, x1 = min(p.x0 for p in parts), max(p.x1 for p in parts)
            z0, z1 = min(p.z0 for p in parts), max(p.z1 for p in parts)
            b.label(x0, x1, z0, z1, ["Kasten", f"{fmt(x1 - x0)} × {fmt(z1 - z0)}"])
        if comp[2] + comp[3] == 0:
            b.label(comp[0], comp[0] + comp[1], t, corpus_h - t,
                    [f"Abteil {c + 1}", "mit Tür" if comp[4] else "offen"])
    b.mark("v", section_x, "A")
    b.mark("h", section_z, "B")

    # C: side section through the first compartment with drawers
    c_view = View(f"Schnitt A–A (Abteil {section_c + 1})", boxes, "right", cut=-section_x)
    c_view.dim("bottom", 1, [c_view.umin, c_view.umax])
    ys = [c_view.umin, depth - t, depth]
    zs = [0, t, corpus_h - t, corpus_h]
    for parts in drawers.values():
        ys += [min(p.y0 for p in parts), max(p.y1 for p in parts)]
        zs += [min(p.z0 for p in parts), max(p.z1 for p in parts)]
    c_view.dim("top", 1, ys)
    c_view.dim("right", 1, zs)
    if wheel > 0:
        c_view.set_ground(-wheel)
        c_view.dim("right", 2, [-wheel, 0])

    # D: horizontal section through the topmost drawer
    d = View("Schnitt B–B", boxes, "top", cut=-section_z)
    xs = [0, width]
    for c, comp in enumerate(comps):
        xs += [comp[0], comp[0] + comp[1]]
        for parts in drawers_of(boxes, c).values():
            xs += [min(p.x0 for p in parts), max(p.x1 for p in parts)]
    d.dim("bottom", 1, xs)
    d.dim("left", 1, [d.vmin, d.vmax])

    return a, b, c_view, d


# ---------------------------------------------------------------- sheet 2

def drawer_detail_views(info, boxes):
    """Two views (front section, side section) per distinct drawer box."""
    types = {}
    for c in range(len(info["compartments"])):
        for unit, parts in drawers_of(boxes, c).items():
            x0, x1 = min(p.x0 for p in parts), max(p.x1 for p in parts)
            z0, z1 = min(p.z0 for p in parts), max(p.z1 for p in parts)
            key = (round(x1 - x0, 1), round(z1 - z0, 1))
            types.setdefault(key, []).append(parts)

    t = info["drawerThickness"]
    floor_z, floor_t = info["drawerFloorZ"], info["drawerFloorThickness"]
    views = []
    for (w, h), all_parts in sorted(types.items(), reverse=True):
        parts = all_parts[0]
        x0, x1 = min(p.x0 for p in parts), max(p.x1 for p in parts)
        y0, y1 = min(p.y0 for p in parts), max(p.y1 for p in parts)
        z0, z1 = min(p.z0 for p in parts), max(p.z1 for p in parts)
        name = f"{fmt(w)} × {fmt(h)}, {len(all_parts)}×"

        front = View(f"Kasten {name}: Schnitt quer", parts, "front", cut=(y0 + y1) / 2)
        front.dim("bottom", 1, [x0, x0 + t, x1 - t, x1])
        front.dim("bottom", 2, [x0, x1])
        front.dim("left", 1, [z0, z0 + floor_z, z0 + floor_z + floor_t, z1])
        front.dim("right", 1, [z0, z1])

        side = View("Schnitt längs", parts, "right", cut=-(x0 + x1) / 2)
        side.dim("bottom", 1, [y0, y0 + t, y1 - t, y1])
        side.dim("bottom", 2, [y0, y1])
        views.append([front, side])
    return views


def notes(info, total):
    t, dt = fmt(info["thickness"]), fmt(info["drawerThickness"])
    lines = [
        "Alle Masse in mm.",
        f"Korpus und Fronten: {info['material']} {t} mm, Schubladenkasten {dt} mm, "
        f"Schubladenböden {fmt(info['drawerFloorThickness'])} mm.",
        f"Fronten {'innenliegend' if info['drawerEnclosed'] else 'aufliegend'}, "
        f"Fuge {fmt(info['frontClearance'])} mm (am Rand {fmt(info['frontClearance'] / 2)} mm).",
        "Schubladenkasten: Seiten über die ganze Tiefe, Vorder- und Rückwand dazwischen.",
        f"Boden ringsum in Nut: {fmt(info['drawerFloorGrooveDepth'])} mm tief, "
        f"{fmt(info['drawerFloorThickness'])} mm breit, Unterkante Nut "
        f"{fmt(info['drawerFloorZ'])} mm über Kastenunterkante.",
        f"Seitliche Luft für Auszüge: {fmt(info['drawerSideClearance'])} mm pro Seite "
        f"(Kastenbreite = lichte Abteilbreite − {fmt(2 * info['drawerSideClearance'])} mm).",
        f"Kastentiefe {fmt(info['drawerDepth'])} mm, Auszüge passend wählen.",
        f"Kasten {fmt(info['drawerBottomClearance'])} mm über dem Korpusboden, "
        f"mind. {fmt(info['drawerTopClearance'])} mm unter dem Deckel.",
    ]
    if info["wheelHeight"] > 0:
        lines.append(f"Rollenhöhe {fmt(info['wheelHeight'])} mm, Gesamthöhe mit Rollen {fmt(info['height'])} mm.")
    if any(comp[4] for comp in info["compartments"]):
        lines.append("Türen: Scharniere (Topfbänder) nicht dargestellt.")
    lines.append(f"Preis total {total}: alle Teile zum m²-Preis des Korpusmaterials gerechnet.")
    return lines


def wrap(text, chars):
    words, lines, current = text.split(), [], ""
    for w in words:
        if current and len(current) + 1 + len(w) > chars:
            lines.append(current)
            current = w
        else:
            current = f"{current} {w}".strip()
    return lines + [current]


def render_parts_table(svg, rows, total, x, y):
    cols = [("Pos", 10, "middle"), ("Bezeichnung", 78, "start"), ("Material", 26, "start"),
            ("Anzahl", 15, "end"), ("Breite", 16, "end"), ("Länge", 16, "end"),
            ("Dicke", 13, "end"), ("Preis", 18, "end")]
    row_h = 6
    table_w = sum(w for _, w, _ in cols)
    svg.text(x, y + 4.5, "Stückliste", size=3.5, anchor="start", bold=True)
    y += TITLE_SPACE
    body = [[r[0], r[1], r[2], r[3], r[4], r[5], r[6], f"{float(r[7]):.2f}"] for r in rows]
    body.append(["", "Total", "", "", "", "", "", f"{total:.2f}"])
    for n, cells in enumerate([[c for c, _, _ in cols]] + body):
        top = y + n * row_h
        svg.rect(x, top, table_w, row_h, width=0.35 if n in (0, len(body)) else 0.2)
        cx = x
        for (header, w, anchor), cell in zip(cols, cells):
            tx = {"start": cx + 1.5, "middle": cx + w / 2, "end": cx + w - 1.5}[anchor]
            svg.text(tx, top + 4.2, cell, size=2.6, anchor=anchor, bold=n == 0 or n == len(body))
            cx += w
    cx = x
    for _, w, _ in cols[:-1]:
        cx += w
        svg.line(cx, y, cx, y + (len(body) + 1) * row_h, 0.2)
    return table_w, TITLE_SPACE + (len(body) + 1) * row_h


# ---------------------------------------------------------------- main

def export(scad, pdf):
    info, boxes, csv_lines = load(scad)
    name = scad.stem
    out = scad.parent

    csv_path = out / f"{name}.csv"
    csv_path.write_text("\n".join(csv_lines) + "\n", encoding="utf-8")

    rows = [l.split(";") for l in csv_lines[1:] if not l.startswith(";Total")]
    total = float(csv_lines[-1].split(";")[-1])
    pos_of = {part_key(r[1], r[4:7]): r[0] for r in rows}

    # sheet 1: views and sections
    a, b, c, d = sheet_views(info, boxes, pos_of)
    n1, rows1 = fit_layout([[[a, c], [d, b]], [[a, c, b], [d]], [[a, b], [c, d]]],
                           AREA_X1 - AREA_X0, AREA_Y1 - AREA_Y0)
    svg1 = Svg()
    place_rows(svg1, rows1, n1, AREA_X0, AREA_Y0)
    frame_and_title(svg1, name, f"1:{fmt(n1)}", "1 / 2", info, boxes)

    # sheet 2: parts list, notes and drawer details
    svg2 = Svg()
    table_w, table_h = render_parts_table(svg2, rows, total, AREA_X0, AREA_Y0)
    notes_x = AREA_X0 + table_w + 12
    svg2.text(notes_x, AREA_Y0 + 4.5, "Hinweise", size=3.5, anchor="start", bold=True)
    ny = AREA_Y0 + TITLE_SPACE + 3
    chars = int((AREA_X1 - notes_x) / (2.6 * 0.55))
    for note in notes(info, f"{total:.2f}"):
        for n, line in enumerate(wrap(note, chars - 2)):
            svg2.text(notes_x + (2.5 if n else 0), ny, ("– " if n == 0 else "") + line, size=2.6, anchor="start")
            ny += 3.8
        ny += 0.8
    details_y = AREA_Y0 + max(table_h, ny - AREA_Y0) + 8
    detail_rows = drawer_detail_views(info, boxes)
    n2 = None
    if detail_rows:
        flat = [v for pair in detail_rows for v in pair]
        n2, rows2 = fit_layout([[flat], detail_rows], AREA_X1 - AREA_X0, AREA_Y1 - details_y)
        place_rows(svg2, rows2, n2, AREA_X0, details_y)
    frame_and_title(svg2, name, f"1:{fmt(n2)}" if n2 else "–", "2 / 2", info, boxes)

    sheets = [out / f"{name}-plan-1.svg", out / f"{name}-plan-2.svg"]
    svg1.save(sheets[0])
    svg2.save(sheets[1])
    written = [csv_path] + sheets

    if pdf:
        pdf_path = make_pdf(sheets, out / f"{name}-plan.pdf")
        if pdf_path:
            written.append(pdf_path)
    print(f"{scad.name}: " + ", ".join(p.name for p in written))


def make_pdf(svgs, target):
    if not (shutil.which("inkscape") and shutil.which("pdfunite")):
        print("PDF übersprungen: inkscape und pdfunite werden benötigt", file=sys.stderr)
        return None
    with tempfile.TemporaryDirectory() as tmp:
        pages = []
        for svg in svgs:
            page = Path(tmp) / (svg.stem + ".pdf")
            subprocess.run(["inkscape", "--export-type=pdf", f"--export-filename={page}", str(svg)],
                           check=True, capture_output=True)
            pages.append(str(page))
        subprocess.run(["pdfunite", *pages, str(target)], check=True, capture_output=True)
    return target


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("files", nargs="+", type=Path, help=".scad files that use cupboard-library.scad")
    parser.add_argument("--no-pdf", action="store_true", help="only write CSV and SVG")
    args = parser.parse_args()
    for f in args.files:
        export(f.resolve(), not args.no_pdf)


if __name__ == "__main__":
    main()
