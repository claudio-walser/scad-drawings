hasDoor = false;
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

innerWidth = width - 2 * thickness;

corpusHeight = height - wheelHeight;
corpusInnerHeight = corpusHeight - thickness * 2;
corpusCalculationHeight = drawerEnclosed ? corpusInnerHeight : corpusHeight;

// Einteilung in Rastereinheiten: kleine Schublade = 1 Einheit, grosse = 2 Einheiten.
// Grosse Schubladen sind immer ganz unten.
drawerUnits = smallDrawers + largeDrawers * 2;
drawerCount = smallDrawers + largeDrawers;
assert(drawerCount > 0, "Mindestens eine Schublade nötig");

// Liste aller Schubladen von unten nach oben: [Starteinheit, Grösse in Einheiten]
drawers = concat(
	[for (i = [0:1:largeDrawers - 1]) [i * 2, 2]],
	[for (i = [0:1:smallDrawers - 1]) [largeDrawers * 2 + i, 1]]
);

// Raster der Fronten: aussen über die ganze Korpushöhe, innen nur über den Innenraum
frontPitch = corpusCalculationHeight / drawerUnits;
frontStartZ = drawerEnclosed ? thickness : 0;
// auf ganze mm gerundet; die Differenz wird gleichmässig auf die Fugen verteilt
frontHeightSmall = round(frontPitch - frontClearance);
frontHeightLarge = round(frontPitch * 2 - frontClearance);
frontInsetSmall = (frontPitch - frontHeightSmall) / 2;
frontInsetLarge = (frontPitch * 2 - frontHeightLarge) / 2;

function frontHeight(size) = size == 1 ? frontHeightSmall : frontHeightLarge;
function frontZ(unit, size) = frontStartZ + unit * frontPitch + (size == 1 ? frontInsetSmall : frontInsetLarge);

// Schubladenkästen: eigenes gleichmässiges Raster (drawerPitch pro Einheit).
// - unterster Kasten steht drawerBottomClearance über dem Korpusboden
// - oberster Kasten steht bündig auf der Unterkante seiner Front
//   (oder höher, falls sonst drawerTopClearance zwischen den Kästen fehlen würde)
// - oberster Kasten hält drawerTopClearance zum Korpusdeckel
// - grosser Kasten = kleiner Kasten + eine Rastereinheit
drawerBottomZ = thickness + drawerBottomClearance;
drawerTopLimit = corpusHeight - thickness - drawerTopClearance;
topSize = smallDrawers > 0 ? 1 : 2;
topFrontZ = frontZ(drawerUnits - topSize, topSize);
// Unterkante eines (gedachten) kleinen Kastens in der obersten Einheit
topUnitDrawerZ = drawerCount == 1
	? max(drawerBottomZ, topFrontZ)
	: max(
		((drawerUnits - 1) * (drawerTopLimit + drawerTopClearance) + drawerBottomZ) / drawerUnits,
		(topFrontZ * (drawerUnits - 1) - drawerBottomZ * (topSize - 1)) / (drawerUnits - topSize)
	);
drawerPitch = drawerCount == 1 ? 0 : (topUnitDrawerZ - drawerBottomZ) / (drawerUnits - 1);
// auf ganze mm gerundet (Abstand zum Deckel kann dadurch bis 0.5 mm kleiner werden)
drawerSideHeightSmall = round(drawerTopLimit - topUnitDrawerZ);
drawerSideHeightLarge = round(drawerTopLimit - topUnitDrawerZ + drawerPitch);

function drawerHeight(size) = size == 1 ? drawerSideHeightSmall : drawerSideHeightLarge;
function drawerZ(unit) = drawerBottomZ + unit * drawerPitch;

if (smallDrawers > 0) echo(str("Kastenhöhe klein: ", drawerSideHeightSmall, " / Fronthöhe klein: ", frontHeightSmall));
if (largeDrawers > 0) echo(str("Kastenhöhe gross: ", drawerSideHeightLarge, " / Fronthöhe gross: ", frontHeightLarge));

// Masse der Schubladenkästen (auch für die Stückliste)
drawerDepth = drawerEnclosed ? depth - 2 * thickness - drawerDepthClearance : depth - thickness - drawerDepthClearance;
drawerInnerWidth = innerWidth - drawerThickness * 2 - drawerSideClearance * 2;
// Boden liegt ringsum gleich tief in einer Nut in Seiten, Vorder- und Rückwand
drawerFloorGrooveDepth = 5;
drawerFloorZ = 10;
drawerFloorWidth = drawerInnerWidth + drawerFloorGrooveDepth * 2;
drawerFloorDepth = drawerDepth - drawerThickness * 2 + drawerFloorGrooveDepth * 2;
drawerFloorThickness = 6;

// Korpus-Seitenwände: bei innen liegenden Fronten um die Frontdicke kürzer
corpusWallDepth = drawerEnclosed ? depth - thickness : depth;

material = "Birke Multiplex";
pricePerQM = 19.32;

module corpus() {
	wallTranslateY = drawerEnclosed ? thickness : 0;

	translate([0, wallTranslateY, thickness]) {
		// left wall
		cube([thickness, corpusWallDepth, corpusInnerHeight]);

		// right wall
		translate([innerWidth + thickness, 0, 0])
		cube([thickness, corpusWallDepth, corpusInnerHeight]);
	}

	// bottom
	cube([width, depth, thickness]);

	// top
	translate([0, 0, corpusHeight - thickness])
	cube([width, depth, thickness]);

	// back wall
	translate([thickness, depth - thickness, thickness])
	cube([innerWidth, thickness, corpusHeight - thickness * 2]);
}

// Preis einer Position (Anzahl × Fläche × m²-Preis).
// Alle Teile werden zum Preis des Korpusmaterials gerechnet: dünnere Platten
// für die Schubladen sind günstiger, der Gesamtpreis ist also eher zu hoch.
function partPrice(part) = part[1] * part[2] * part[3] / 1000000 * pricePerQM;
function sumList(v, i = 0) = i < len(v) ? v[i] + sumList(v, i + 1) : 0;

// [Bezeichnung, Anzahl, Breite, Länge, Dicke]; Positionen mit Anzahl 0 werden weggelassen
allParts = [
	["Korpus Seiten", 2, corpusWallDepth, corpusInnerHeight, thickness],
	["Korpus Boden und Deckel", 2, depth, width, thickness],
	["Korpus Rückwand", 1, innerWidth, corpusInnerHeight, thickness],
	["Schubladen Fronten klein", smallDrawers, frontHeightSmall, width - frontClearance, thickness],
	["Schubladen Fronten gross", largeDrawers, frontHeightLarge, width - frontClearance, thickness],
	["Schubladenkasten Seiten klein", smallDrawers * 2, drawerSideHeightSmall, drawerDepth, drawerThickness],
	["Schubladenkasten Seiten gross", largeDrawers * 2, drawerSideHeightLarge, drawerDepth, drawerThickness],
	["Schubladenkasten Vorder- und Rückwand klein", smallDrawers * 2, drawerSideHeightSmall, drawerInnerWidth, drawerThickness],
	["Schubladenkasten Vorder- und Rückwand gross", largeDrawers * 2, drawerSideHeightLarge, drawerInnerWidth, drawerThickness],
	["Schubladenböden", drawerCount, drawerFloorDepth, drawerFloorWidth, drawerFloorThickness],
];
parts = [for (part = allParts) if (part[1] > 0) part];

module partsList() {
	echo("Pos;Bezeichnung;Typ;Anzahl;Breite;Länge;Dicke;Preis");
	for (i = [0:len(parts) - 1]) {
		part = parts[i];
		echo(str(i + 1, ";", part[0], ";", material, ";", part[1], ";", part[2], ";", part[3], ";", part[4], ";", partPrice(part)));
	}
	echo(str(";Total;;;;;;", sumList([for (part = parts) partPrice(part)])));
}

module drawer(drawerHeight) {
	color("darkgreen") {

		// left
		cube([drawerThickness, drawerDepth, drawerHeight]);

		// right
		translate([innerWidth - drawerThickness - drawerSideClearance * 2, 0, 0])
		cube([drawerThickness, drawerDepth, drawerHeight]);

		// front
		translate([drawerThickness, 0, 0])
		cube([drawerInnerWidth, drawerThickness, drawerHeight]);

		// back
		translate([drawerThickness, drawerDepth - drawerThickness, 0])
		cube([drawerInnerWidth, drawerThickness, drawerHeight]);
	}

	// floor
	color("purple") {
		translate([drawerThickness - drawerFloorGrooveDepth, drawerThickness - drawerFloorGrooveDepth, drawerFloorZ])
		cube([drawerFloorWidth, drawerFloorDepth, drawerFloorThickness]);
	}
}

module frontPanel(frontHeight) {
	cube([width - frontClearance, thickness, frontHeight]);
}

corpus();

drawerY = drawerEnclosed ? thickness : 0;

for (d = drawers) {
	unit = d[0];
	size = d[1];
	fz = frontZ(unit, size);
	fh = frontHeight(size);
	dz = drawerZ(unit);
	dh = drawerHeight(size);

	assert(dz >= fz - 0.01, str("Schubladenkasten in Einheit ", unit, " ragt unter seine Front"));
	assert(dz + dh <= fz + fh + 0.01, str("Schubladenkasten in Einheit ", unit, " ragt über seine Front"));

	// Kasten: eigenes Raster, bleibt immer hinter seiner Front
	translate([thickness + drawerSideClearance, drawerY, dz])
	drawer(dh);

	// Front: Raster über corpusCalculationHeight
	translate([frontClearance / 2, drawerY - thickness, fz])
	frontPanel(fh);
}

partsList();
