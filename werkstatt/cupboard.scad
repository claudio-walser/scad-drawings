hasDoor = false;
largeDrawers = 0; //1:3; 2:1
smallDrawers = 5; // 5||3||1
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
drawerHeightSmall = (corpusCalculationHeight - frontClearance) / smallDrawers;
drawerSideHeightSmall = (corpusInnerHeight - frontClearance) / smallDrawers - drawerTopClearance - drawerBottomClearance;

material = "Birke Multiplex";
pricePerQM = 80;

module corpus() {
	wallDepth = drawerEnclosed ? depth - thickness : depth;
	wallTranslateY = drawerEnclosed ? thickness : 0;

	translate([0, wallTranslateY, thickness]) {
		// left wall
		cube([thickness, wallDepth, corpusInnerHeight]);

		// right wall
		translate([innerWidth, 0, 0])
		cube([thickness, wallDepth, corpusInnerHeight]);
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

module echoPart(pos, desc, count, width, length, thickness) {
    echo(str(pos, ";", desc, ";", material, ";", count, ";", width, ";", length, ";", thickness, ";", width * length / 1000000 * pricePerQM));
}

module partsList() {
    echo("Pos;Bezeichnung;Typ;Anzahl;Breite;Länge;Dicke;Preis");
    echoPart(1, "Korpus Seiten", 2, depth, corpusHeight, thickness);
    echoPart(2, "Korpus Boden und Deckel", 2, depth, innerWidth, thickness);
    echoPart(3, "Korpus Rückwand", 1, innerWidth, corpusHeight - thickness * 2, thickness);
}

module drawer(type = "small", num = 0) {
	drawerDepth = drawerEnclosed ? depth - 2 * thickness - drawerDepthClearance : depth - thickness - drawerDepthClearance;
	drawerInnerWidth = innerWidth - drawerThickness * 2 - drawerSideClearance * 2;

	color("darkgreen") {
		drawerHeight = type == "small" ? drawerSideHeightSmall : 240;

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
		translate([5, 5, 10])
		cube([drawerInnerWidth - drawerThickness * 2 + 10 + drawerSideClearance * 2, drawerDepth - drawerThickness * 2 + 10, 6]);
	}

	// front panel
	drawerColor = num % 2 == 0 ? "orange" : "purple";
	translate([-thickness - drawerSideClearance + frontClearance / 2, -thickness, -drawerBottomClearance - frontClearance])
	color(drawerColor) cube([width - frontClearance, thickness, drawerHeightSmall - frontClearance]);
}

#corpus();

drawerY = drawerEnclosed ? thickness : 0;
corpusOuterAddition = drawerEnclosed ? 0 : thickness - frontClearance * 2;

for (num = [0:smallDrawers - 1]) {
	zOffset = num * drawerHeightSmall - thickness - 2 * frontClearance + drawerTopClearance - corpusOuterAddition;
	translate([thickness + drawerSideClearance, drawerY, corpusInnerHeight - drawerSideHeightSmall - frontClearance - zOffset])
	drawer(num = num);
}

partsList();
