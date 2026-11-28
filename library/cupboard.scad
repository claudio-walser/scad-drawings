// Library for cabinets with drawers (model and parts list).
// Usage:
//   include <cupboard-library.scad>
//   width = ...;   // override only the parameters that differ
//   cupboard();
//   partsList();
// The parameters below are defaults. Since OpenSCAD uses the last value when
// a variable is assigned more than once, assignments after the include take effect.

// ---- Parameters (defaults) ----
// Compartments without drawers get a door (otherwise they stay open)
hasDoor = false;
// Fronts wider than this get a double door instead of a single one
doorMaxWidth = 600;
largeDrawers = 1; //1:3; 2:1
smallDrawers = 3; // 5||3||1
drawerSideClearance = 12.5;
drawerTopClearance = 15;
drawerBottomClearance = 5;
drawerDepthClearance = 20;
drawerThickness = 12;

drawerEnclosed = false;

wheelHeight = 108;

frontClearance = 4;
height = 922;
width = 500;
depth = 400;
thickness = 18;

// Number of drawer compartments side by side, separated by dividers of corpus thickness
compartments = 1;
// Clear (inner) width of each compartment from left to right. undef entries, and
// entries missing at the end, are flexible: they share the remaining width evenly.
// At least one compartment must stay flexible so the total width can be met.
// Example: compartmentWidths = [undef, undef, 242];
compartmentWidths = [];
// Drawers per compartment from left to right. true (and entries missing at the end)
// use the default layout smallDrawers / largeDrawers, false gives a compartment
// without drawers (door or open, see hasDoor). An entry [small, large] sets a
// different layout for that compartment.
// Example: compartmentDrawers = [false, true, true];
compartmentDrawers = [];

material = "MDF";
pricePerQM = 19.32;

// Echo all parts with position and size (used by export-cupboard.py)
exportData = false;

// ---- Calculations ----

innerWidth = width - 2 * thickness;
requestedWidths = [for (i = [0:compartments - 1]) i < len(compartmentWidths) ? compartmentWidths[i] : undef];
flexibleCount = len([for (w = requestedWidths) if (is_undef(w)) w]);
fixedWidthSum = sumList([for (w = requestedWidths) if (!is_undef(w)) w]);
flexibleWidth = (innerWidth - (compartments - 1) * thickness - fixedWidthSum) / flexibleCount;
assert(len(compartmentWidths) <= compartments, "compartmentWidths hat mehr Einträge als compartments");
assert(flexibleCount > 0, "Mindestens ein Abteil muss ohne Breite (undef) bleiben");
assert(flexibleWidth > 0, "Die fixen Abteilbreiten sind grösser als der verfügbare Platz");

// Clear width of compartment i
function compartmentWidth(i) = is_undef(requestedWidths[i]) ? flexibleWidth : requestedWidths[i];
// Left inner edge of compartment i
function compartmentX(i) = thickness + sumList([for (j = [0:1:i - 1]) compartmentWidth(j) + thickness]);

corpusHeight = height - wheelHeight;
corpusInnerHeight = corpusHeight - thickness * 2;
corpusCalculationHeight = drawerEnclosed ? corpusInnerHeight : corpusHeight;

// Drawer configuration of compartment c: [small, large]
function drawerConfig(c) = let (entry = c < len(compartmentDrawers) ? compartmentDrawers[c] : true)
	is_list(entry) ? entry
	: entry == false ? [0, 0]
	: [smallDrawers, largeDrawers];
function smallDrawersIn(c) = drawerConfig(c)[0];
function largeDrawersIn(c) = drawerConfig(c)[1];
assert(len(compartmentDrawers) <= compartments, "compartmentDrawers hat mehr Einträge als compartments");
for (c = [0:compartments - 1])
	assert(smallDrawersIn(c) >= 0 && largeDrawersIn(c) >= 0, str("Ungültige Schubladenzahl in Abteil ", c + 1));

// Layout in grid units per compartment: small drawer = 1 unit, large drawer = 2 units.
// Large drawers are always at the bottom.
function drawerUnits(c) = smallDrawersIn(c) + largeDrawersIn(c) * 2;
function drawerCount(c) = smallDrawersIn(c) + largeDrawersIn(c);

// List of all drawers of compartment c from bottom to top: [start unit, size in units]
function drawers(c) = concat(
	[for (i = [0:1:largeDrawersIn(c) - 1]) [i * 2, 2]],
	[for (i = [0:1:smallDrawersIn(c) - 1]) [largeDrawersIn(c) * 2 + i, 1]]
);

// Front grid: overlay fronts span the full corpus height, inset fronts only the interior
function frontPitch(c) = corpusCalculationHeight / drawerUnits(c);
frontStartZ = drawerEnclosed ? thickness : 0;
// rounded to whole mm; the difference is distributed evenly across the gaps
function frontHeight(c, size) = round(frontPitch(c) * size - frontClearance);
function frontZ(c, unit, size) = frontStartZ + unit * frontPitch(c) + (frontPitch(c) * size - frontHeight(c, size)) / 2;

// Horizontally, the fronts cover the full cabinet width: each compartment gets its
// clear width plus an equal share of all walls (equal compartments -> equal fronts)
function frontPitchX(i) = compartmentWidth(i) + (compartments + 1) * thickness / compartments;
function frontPitchStartX(i) = sumList([for (j = [0:1:i - 1]) frontPitchX(j)]);
// rounded to whole mm; the difference is split evenly on both sides
function frontWidth(i) = round(frontPitchX(i) - frontClearance);
function frontX(i) = frontPitchStartX(i) + (frontPitchX(i) - frontWidth(i)) / 2;

// Doors: same plane and horizontal grid as the drawer fronts, over the full front height
doorHeight = round(corpusCalculationHeight - frontClearance);
doorZ = frontStartZ + (corpusCalculationHeight - doorHeight) / 2;
function hasCompartmentDoor(c) = hasDoor && drawerCount(c) == 0;
function doorCount(c) = frontWidth(c) > doorMaxWidth ? 2 : 1;
// double doors: the front width is split in two, with at least frontClearance between
// the leaves (rounded down to whole mm, the gap grows by the rest)
function doorWidth(c) = doorCount(c) == 1 ? frontWidth(c) : floor((frontWidth(c) - frontClearance) / 2);
function doorX(c, i) = frontX(c) + i * (frontWidth(c) - doorWidth(c));

// Drawer boxes: their own even grid per compartment (drawerPitch per unit).
// - bottom box sits drawerBottomClearance above the corpus bottom
// - top box sits flush with the lower edge of its front
//   (or higher if drawerTopClearance between the boxes would otherwise be missing)
// - top box keeps drawerTopClearance to the corpus top
// - large box = small box + one grid unit
drawerBottomZ = thickness + drawerBottomClearance;
drawerTopLimit = corpusHeight - thickness - drawerTopClearance;
// Lower edge of an (imaginary) small box in the topmost unit
function topUnitDrawerZ(c) = let (
		units = drawerUnits(c),
		topSize = smallDrawersIn(c) > 0 ? 1 : 2,
		topFrontZ = frontZ(c, units - topSize, topSize)
	)
	drawerCount(c) == 1
		? max(drawerBottomZ, topFrontZ)
		: max(
			((units - 1) * (drawerTopLimit + drawerTopClearance) + drawerBottomZ) / units,
			(topFrontZ * (units - 1) - drawerBottomZ * (topSize - 1)) / (units - topSize)
		);
function drawerPitch(c) = drawerCount(c) == 1 ? 0 : (topUnitDrawerZ(c) - drawerBottomZ) / (drawerUnits(c) - 1);
// rounded to whole mm (clearance to the top may shrink by up to 0.5 mm)
function drawerHeight(c, size) = round(drawerTopLimit - topUnitDrawerZ(c) + (size - 1) * drawerPitch(c));
function drawerZ(c, unit) = drawerBottomZ + unit * drawerPitch(c);

// Drawer box dimensions (also used for the parts list)
drawerDepth = drawerEnclosed ? depth - 2 * thickness - drawerDepthClearance : depth - thickness - drawerDepthClearance;
// rounded to whole mm; the box is centered in its compartment
function drawerInnerWidth(c) = round(compartmentWidth(c) - drawerThickness * 2 - drawerSideClearance * 2);
function drawerOuterWidth(c) = drawerInnerWidth(c) + drawerThickness * 2;
// Floor sits equally deep in a groove in the sides, front and back all around
drawerFloorGrooveDepth = 5;
drawerFloorZ = 10;
function drawerFloorWidth(c) = drawerInnerWidth(c) + drawerFloorGrooveDepth * 2;
drawerFloorDepth = drawerDepth - drawerThickness * 2 + drawerFloorGrooveDepth * 2;
drawerFloorThickness = 6;

// Corpus side walls: shorter by the front thickness when fronts are inset
corpusWallDepth = drawerEnclosed ? depth - thickness : depth;
// Dividers: like side walls, but end at the back wall
dividerDepth = corpusWallDepth - thickness;

// ---- All parts as data ----
// Every part is an axis-aligned box:
//   [type, part name, compartment, index, position, size, color]
// The part name matches the parts list. cupboard() draws these boxes, and
// export-cupboard.py reads them to create the construction drawings.
function box(type, name, c, i, pos, size, col = undef) = [type, name, c, i, pos, size, col];
function sizeName(size) = size == 1 ? "klein" : "gross";

wallY = drawerEnclosed ? thickness : 0;
drawerY = drawerEnclosed ? thickness : 0;
frontY = drawerY - thickness;

corpusBoxes = concat(
	[
		box("side", "Korpus Seiten", 0, 0, [0, wallY, thickness], [thickness, corpusWallDepth, corpusInnerHeight]),
		box("side", "Korpus Seiten", compartments - 1, 1, [innerWidth + thickness, wallY, thickness], [thickness, corpusWallDepth, corpusInnerHeight]),
	],
	[for (i = [1:1:compartments - 1])
		box("divider", "Korpus Trennwände", i, i, [compartmentX(i) - thickness, wallY, thickness], [thickness, dividerDepth, corpusInnerHeight])],
	[
		box("bottom", "Korpus Boden und Deckel", -1, 0, [0, 0, 0], [width, depth, thickness]),
		box("top", "Korpus Boden und Deckel", -1, 1, [0, 0, corpusHeight - thickness], [width, depth, thickness]),
		box("back", "Korpus Rückwand", -1, 0, [thickness, depth - thickness, thickness], [innerWidth, thickness, corpusHeight - thickness * 2]),
	]
);

// Drawer box: centered in its compartment, floor in a groove all around
function drawerBoxX(c) = compartmentX(c) + (compartmentWidth(c) - drawerOuterWidth(c)) / 2;
function drawerBoxes(c, unit, size) = let (
		x = drawerBoxX(c),
		z = drawerZ(c, unit),
		h = drawerHeight(c, size),
		iw = drawerInnerWidth(c),
		t = drawerThickness,
		g = drawerFloorGrooveDepth,
		n = sizeName(size)
	) [
		box("drawerSide", str("Schubladenkasten Seiten ", n), c, unit, [x, drawerY, z], [t, drawerDepth, h], "darkgreen"),
		box("drawerSide", str("Schubladenkasten Seiten ", n), c, unit, [x + t + iw, drawerY, z], [t, drawerDepth, h], "darkgreen"),
		box("drawerFrontBack", str("Schubladenkasten Vorder- und Rückwand ", n), c, unit, [x + t, drawerY, z], [iw, t, h], "darkgreen"),
		box("drawerFrontBack", str("Schubladenkasten Vorder- und Rückwand ", n), c, unit, [x + t, drawerY + drawerDepth - t, z], [iw, t, h], "darkgreen"),
		box("drawerFloor", "Schubladenböden", c, unit, [x + t - g, drawerY + t - g, z + drawerFloorZ], [iw + g * 2, drawerFloorDepth, drawerFloorThickness], "purple"),
	];

cupboardBoxes = concat(
	corpusBoxes,
	[for (c = [0:compartments - 1], d = drawers(c)) each drawerBoxes(c, d[0], d[1])],
	// Fronts: grid over corpusCalculationHeight and the full width
	[for (c = [0:compartments - 1], d = drawers(c))
		box("front", str("Schubladen Fronten ", sizeName(d[1])), c, d[0],
			[frontX(c), frontY, frontZ(c, d[0], d[1])], [frontWidth(c), thickness, frontHeight(c, d[1])])],
	[for (c = [0:compartments - 1]) if (hasCompartmentDoor(c)) for (i = [0:doorCount(c) - 1])
		box("door", "Türen", c, i, [doorX(c, i), frontY, doorZ], [doorWidth(c), thickness, doorHeight])]
);

// General data for the construction drawings: [key, value] pairs
cupboardInfo = [
	["width", width], ["depth", depth], ["height", height], ["wheelHeight", wheelHeight],
	["corpusHeight", corpusHeight], ["thickness", thickness], ["material", material],
	["drawerEnclosed", drawerEnclosed], ["frontClearance", frontClearance],
	["drawerThickness", drawerThickness], ["drawerDepth", drawerDepth],
	["drawerSideClearance", drawerSideClearance], ["drawerTopClearance", drawerTopClearance],
	["drawerBottomClearance", drawerBottomClearance],
	["drawerFloorGrooveDepth", drawerFloorGrooveDepth], ["drawerFloorZ", drawerFloorZ],
	["drawerFloorThickness", drawerFloorThickness],
	// per compartment: [x, clear width, small drawers, large drawers, door count]
	["compartments", [for (c = [0:compartments - 1])
		[compartmentX(c), compartmentWidth(c), smallDrawersIn(c), largeDrawersIn(c), hasCompartmentDoor(c) ? doorCount(c) : 0]]],
];

// Price of a line item (count × area × price per m²).
// All parts are priced at the corpus material rate: thinner panels for the
// drawers are cheaper, so the total tends to be on the high side.
function partPrice(part) = part[1] * part[2] * part[3] / 1000000 * pricePerQM;
function sumList(v, i = 0) = i < len(v) ? v[i] + sumList(v, i + 1) : 0;

// [name, count, width, length, thickness]; one entry per compartment for parts
// whose size depends on the compartment width
compartmentList = [0:compartments - 1];
allParts = concat(
	[
		["Korpus Seiten", 2, corpusWallDepth, corpusInnerHeight, thickness],
		["Korpus Boden und Deckel", 2, depth, width, thickness],
		["Korpus Rückwand", 1, innerWidth, corpusInnerHeight, thickness],
		["Korpus Trennwände", compartments - 1, dividerDepth, corpusInnerHeight, thickness],
	],
	[for (c = compartmentList) ["Schubladen Fronten klein", smallDrawersIn(c), frontHeight(c, 1), frontWidth(c), thickness]],
	[for (c = compartmentList) ["Schubladen Fronten gross", largeDrawersIn(c), frontHeight(c, 2), frontWidth(c), thickness]],
	[for (c = compartmentList) ["Schubladenkasten Seiten klein", smallDrawersIn(c) * 2, drawerHeight(c, 1), drawerDepth, drawerThickness]],
	[for (c = compartmentList) ["Schubladenkasten Seiten gross", largeDrawersIn(c) * 2, drawerHeight(c, 2), drawerDepth, drawerThickness]],
	[for (c = compartmentList) ["Schubladenkasten Vorder- und Rückwand klein", smallDrawersIn(c) * 2, drawerHeight(c, 1), drawerInnerWidth(c), drawerThickness]],
	[for (c = compartmentList) ["Schubladenkasten Vorder- und Rückwand gross", largeDrawersIn(c) * 2, drawerHeight(c, 2), drawerInnerWidth(c), drawerThickness]],
	[for (c = compartmentList) ["Schubladenböden", drawerCount(c), drawerFloorDepth, drawerFloorWidth(c), drawerFloorThickness]],
	[for (c = compartmentList) ["Türen", hasCompartmentDoor(c) ? doorCount(c) : 0, doorHeight, doorWidth(c), thickness]]
);

// Merge identical parts (same name and dimensions) by adding up their counts;
// items with count 0 are omitted
function samePart(a, b) = a[0] == b[0] && a[2] == b[2] && a[3] == b[3] && a[4] == b[4];
function firstSamePart(list, i) = min([for (j = [0:i]) if (samePart(list[j], list[i])) j]);
nonEmptyParts = [for (part = allParts) if (part[1] > 0) part];
parts = [
	for (i = [0:len(nonEmptyParts) - 1]) if (firstSamePart(nonEmptyParts, i) == i)
		let (part = nonEmptyParts[i])
		[part[0], sumList([for (other = nonEmptyParts) if (samePart(other, part)) other[1]]), part[2], part[3], part[4]]
];

module partsList() {
	echo("Pos;Bezeichnung;Typ;Anzahl;Breite;Länge;Dicke;Preis");
	for (i = [0:len(parts) - 1]) {
		part = parts[i];
		echo(str(i + 1, ";", part[0], ";", material, ";", part[1], ";", part[2], ";", part[3], ";", part[4], ";", partPrice(part)));
	}
	echo(str(";Total;;;;;;", sumList([for (part = parts) partPrice(part)])));
}

// Whole cabinet: corpus, drawer boxes and fronts
module cupboard() {
	for (c = [0:compartments - 1]) {
		echo(str("Abteil ", c + 1, ": lichte Breite ", compartmentWidth(c), " (", compartmentX(c), " bis ", compartmentX(c) + compartmentWidth(c), ")",
			drawerCount(c) > 0 ? ""
				: hasCompartmentDoor(c) ? str(", ", doorCount(c) == 2 ? "Doppeltür " : "Tür ", doorWidth(c), " x ", doorHeight)
				: ", offen"));
		if (smallDrawersIn(c) > 0) echo(str("  Kastenhöhe klein: ", drawerHeight(c, 1), " / Fronthöhe klein: ", frontHeight(c, 1)));
		if (largeDrawersIn(c) > 0) echo(str("  Kastenhöhe gross: ", drawerHeight(c, 2), " / Fronthöhe gross: ", frontHeight(c, 2)));
	}

	for (c = [0:compartments - 1], d = drawers(c)) {
		unit = d[0];
		size = d[1];
		fx = frontX(c);
		fz = frontZ(c, unit, size);
		dx = drawerBoxX(c);
		dz = drawerZ(c, unit);
		assert(dz >= fz - 0.01, str("Schubladenkasten in Abteil ", c + 1, ", Einheit ", unit, " ragt unter seine Front"));
		assert(dz + drawerHeight(c, size) <= fz + frontHeight(c, size) + 0.01, str("Schubladenkasten in Abteil ", c + 1, ", Einheit ", unit, " ragt über seine Front"));
		assert(dx >= fx && dx + drawerOuterWidth(c) <= fx + frontWidth(c), str("Schubladenkasten in Abteil ", c + 1, " ragt seitlich über seine Front"));
	}

	for (b = cupboardBoxes)
		translate(b[4])
		if (is_undef(b[6])) cube(b[5]);
		else color(b[6]) cube(b[5]);

	if (exportData) {
		echo(cupboardInfo = cupboardInfo);
		for (b = cupboardBoxes) echo(box = b);
	}
}
