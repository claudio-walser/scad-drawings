hasDoor = false;
largeDrawers = 0;
smallDrawers = 0;

wheelHeight = 108;

frontClearance = 4;

height = 922;
width = 500;
depth = 400;
thickness = 18;

corpusHeight = height - wheelHeight;

material = "Birke Multiplex";

pricePerQM = 80;

module corpus() {
	// reference
	//translate([0, 0, -wheelHeight])
	//#cube([width, depth, height]);

	/* corpus */

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


corpus();
partsList();