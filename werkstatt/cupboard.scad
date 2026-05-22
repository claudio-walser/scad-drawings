hasDoor = false;
largeDrawers = 0; //1:3; 2:1
smallDrawers = 5; // 5||3||1
drawerSideClearance = 12.5;
drawerTopClearance = 15;
drawerBottomClearance = 5;
drawerDepthClearance = 20;
//drawerHeightSmall = 134;
drawerThickness = 12;

drawerEnclosed = true;


wheelHeight = 108;

frontClearance = 4;
height = 922;
width = 500;
depth = 400;
thickness = 18;


corpusHeight = height - wheelHeight;
corpusInnerHeight = corpusHeight - thickness * 2;
corpusCalculationHeight = drawerEnclosed == true ? corpusInnerHeight : corpusHeight;
drawerHeightSmall = (corpusCalculationHeight - frontClearance) / smallDrawers;
drawerSideHeightSmall = drawerHeightSmall - drawerTopClearance - drawerBottomClearance;

material = "Birke Multiplex";
pricePerQM = 80;

module corpus() {
	// reference
	//color("yellow") {
	//	translate([0, 0, -wheelHeight])
	//	cube([width, depth, height]);
	//}
	/* corpus */

	//color("yellow") {
	//	translate([0, 0, 0])
	//	cube([width, depth, corpusHeight]);
	//}

	wallDepth = drawerEnclosed == true ? depth - thickness : depth;
	wallTranslateY = drawerEnclosed == true ? thickness : 0;
	
	translate([0, wallTranslateY, thickness]) {
		// left wall
		cube([thickness, wallDepth, corpusInnerHeight]);

		// right wall
		translate([width - thickness, 0, 0])
		cube([thickness, wallDepth, corpusInnerHeight]);
	}
	
	// bottom
	translate([0, 0, 0])
	cube([width, depth, thickness]);

	// top
	translate([0, 0, corpusHeight - thickness])
	cube([width, depth, thickness]);

	// back wall
	translate([thickness, depth - thickness, thickness])
	cube([width - thickness * 2, thickness, corpusHeight - thickness * 2]);
}

module echoPart(pos, desc, count, width, length, thickness) {
    echo(str(pos, ";", desc, ";", material,";", count, ";", width,";",length,";",thickness, ";", width*length/1000000*pricePerQM));
}

module partsList() {
    echo("Pos;Bezeichnung;Typ;Anzahl;Breite;Länge;Dicke;Preis");
    echoPart(1, "Korpus Seiten", 2, depth, corpusHeight, thickness);
    echoPart(2, "Korpus Boden und Deckel", 2, depth, width - thickness * 2, thickness);
    echoPart(3, "Korpus Rückwand", 1, width - thickness * 2, corpusHeight - thickness * 2, thickness);
    //echo(str("2;Korpus Boden und Deckel;", material ,";2;", depth,";",width - thickness * 2,";",thickness));
    //echo(str("3;Korpus Rückwand;", material ,";2;", width - thickness * 2,";",corpusHeight - thickness * 2,";",thickness));
}

module drawer(type = "small", last = false, num = 0) {
	
	drawerDepth = drawerEnclosed == true ? depth - thickness - drawerDepthClearance - thickness : depth - thickness - drawerDepthClearance;
	color("darkgreen") {
		drawerHeight = type == "small" ? drawerSideHeightSmall : 240;
		// left
		cube([drawerThickness, drawerDepth, drawerHeight]);

		// right
		translate([width - 2 * thickness - drawerThickness - drawerSideClearance * 2, 0, 0])
		cube([drawerThickness, drawerDepth, drawerHeight]);

		// front
		translate([drawerThickness, 0, 0])
		cube([width - 2 * thickness - drawerThickness * 2 - drawerSideClearance * 2, 12, drawerHeight]);

		// back
		translate([drawerThickness, drawerDepth - drawerThickness, 0])
		cube([width - 2 * thickness - drawerThickness * 2 - drawerSideClearance * 2, 12, drawerHeight]);
	}

	// floor
	color("purple") {
		translate([5, 5, 10])
		cube([width - 2 * thickness - drawerSideClearance * 2 - drawerThickness * 2 + 10, depth - thickness - drawerDepthClearance - drawerThickness * 2 + 10, 6]);
	}

	// front
	drawerColor = num % 2 == 0 ? "orange" : "purple";

	//translate([-thickness - drawerSideClearance + frontClearance/2, -thickness, -drawerBottomClearance - frontClearance])
	//color(drawerColor) cube([width - frontClearance, thickness, drawerHeightSmall - frontClearance]);
}

corpus();

drawerY = drawerEnclosed == true ? thickness : 0;

for (num =[0:smallDrawers - 1]) {
	last = num == smallDrawers - 1 && drawerEnclosed == false ? true : false;
	corpusOuterAddition = drawerEnclosed == true ? 0 : thickness;

	numTop = num * (drawerHeightSmall) - thickness - frontClearance - frontClearance + drawerTopClearance - corpusOuterAddition;
	translate([thickness + drawerSideClearance, drawerY, corpusInnerHeight - drawerSideHeightSmall - frontClearance - numTop])
	//drawer(last = last);
	drawer(last = last, num = num);
}

partsList();
