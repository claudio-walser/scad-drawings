$fn = 256;


difference() {
	scale([4, 4, 4])
	import("crown.stl");


	#translate([0, 0, -3]) {

		// middle
		translate([0, 64, 0])
		cylinder(d = 22, h = 20);

		// middle right
		translate([74.3, 55, 0])
		cylinder(d = 22, h = 20);

		// middle left
		translate([-74.3, 55, 0])
		cylinder(d = 22, h = 20);

		// right
		translate([138, 24.5, 0])
		cylinder(d = 22, h = 20);

		// left
		translate([-138, 24.5, 0])
		cylinder(d = 22, h = 20);


	}
}

