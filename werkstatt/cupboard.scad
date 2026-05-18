hasDoor = false;
largeDrawers = 0; //1:3; 2:1
smallDrawers = 6; // 5||3||1
drawerSideClearance = 12.5;
drawerTopClearance = 15;
drawerBottomClearance = 5;
drawerDepthClearance = 20;
//drawerHeightSmall = 134;
drawerThickness = 12;




wheelHeight = 108;

frontClearance = 4;
height = 922;
width = 500;
depth = 400;
thickness = 18;


corpusHeight = height - wheelHeight;

drawerHeightSmall = (corpusHeight) / smallDrawers - frontClearance;
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


	// left wall
	cube([thickness, depth, corpusHeight]);

	// right wall
	translate([width - thickness, 0, 0])
	cube([thickness, depth, corpusHeight]);

	// bottom
	translate([thickness, 0, 0])
	cube([width - thickness * 2, depth, thickness]);

	// top
	translate([thickness, 0, corpusHeight - thickness])
	cube([width - thickness * 2, depth, thickness]);

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

module drawer(type = "small") {
	
	color("darkgreen") {
		drawerHeight = type == "small" ? drawerSideHeightSmall : 240;
		// left
		cube([drawerThickness, depth - thickness - drawerDepthClearance, drawerHeight]);

		// right
		translate([width - 2 * thickness - drawerThickness - drawerSideClearance * 2, 0, 0])
		cube([drawerThickness, depth - thickness - drawerDepthClearance, drawerHeight]);

		// front
		translate([drawerThickness, 0, 0])
		cube([width - 2 * thickness - drawerThickness * 2 - drawerSideClearance * 2, 12, drawerHeight]);

		// back
		translate([drawerThickness, depth - thickness - drawerDepthClearance - drawerThickness, 0])
		cube([width - 2 * thickness - drawerThickness * 2 - drawerSideClearance * 2, 12, drawerHeight]);
	}

	// floor
	color("purple") {
		translate([5, 5, 10])
		cube([width - 2 * thickness - drawerSideClearance * 2 - drawerThickness * 2 + 10, depth - thickness - drawerDepthClearance - drawerThickness * 2 + 10, 6]);
	}

	// front
	//translate([-thickness - drawerSideClearance + frontClearance/2, -thickness, 0])
	//cube([width - frontClearance, thickness, drawerHeightSmall]);
}

corpus();

for (num =[0:smallDrawers - 1]) {
	numTop = num * (drawerHeightSmall + frontClearance);
	translate([thickness + drawerSideClearance, 0, corpusHeight - drawerSideHeightSmall - thickness - frontClearance - numTop])
	drawer();
}

partsList();
