include <../library/modules.scad>


module niche(height, width, thickness, depth) {
	nicheHeight = height + 2 * thickness;
	nicheWidth = width + 2 * thickness;
	//#translate([thickness, 0, thickness])cube (size=[height, depth, width]);

	// lower board
	boardMitreJoints(nicheWidth, depth, thickness);
	// top board
	translate([0, depth, nicheHeight]) rotate([180, 0, 0]) boardMitreJoints(nicheWidth, depth, thickness);
	// left board
	translate([0, 0, nicheHeight]) rotate([0, 90, 0]) boardMitreJoints(nicheWidth, depth, thickness);

	translate([nicheWidth, 0, 0]) rotate([0, -90, 0]) boardMitreJoints(nicheWidth, depth, thickness);



	module partsList() {
		// Beine Hinten
		echo(str("Nussbaum Bretter unten/oben", ";", "2", ";", width, ";", depth, ";", thickness));
		echo(str("Nussbaum Bretter seitlich", ";", "2", ";", height, ";", depth, ";", thickness));
	}

	partsList();
}