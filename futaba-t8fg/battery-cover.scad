cube([120, 30, 3]);

//difference() {
//	translate([0, 0, 3])
//	rotate([0, 118, 0])
//	cube([15, 30, 3]);
//
//	translate([-7.5, -1, -15])
//	rotate([5, 0, 0])
//	cube([6, 32, 5]);
//
//}

translate([120 - 100, 0, -3.5]) {

	translate([-13, 0, 0]) {
		difference() {
			union() {
				cube([100, 2, 2]);
				translate([0, 2, 0])
				cube([100, 2, 4]);
			}
			translate([92, -4.2, -0.5])
			rotate([0, 0, 25])
			cube([12, 4, 4]);

		}
	}

}


translate([120 - 8, 30 - 2, -3.5]) {
	translate([-13, 0, 0]) {
		cube([8, 2, 2]);
		translate([0, -2, 0])
		cube([8, 2, 4]);
	}

	translate([-105, 0, 0]) {
		cube([8, 2, 2]);
		translate([0, -2, 0])
		cube([8, 2, 4]);
	}
}