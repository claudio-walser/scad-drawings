$fn = 256;

module screw() {
	cylinder(d=5, h=20);

	cylinder(h=5, d1=10, d2=0);

	translate([0, 0, -20])
	cylinder(d=10, h=20);


}


difference() {
	cube([60, 120, 54]);

	translate([30, 125, 24])
	rotate([90, 0, 0])
	cylinder(d = 48, h=130);

	translate([(60 - 47) / 2, -5, -1])
	cube([47, 130, 24]);

	translate([30, 20, 49]) {
		screw();
	}

	translate([30, 60, 49]) {
		screw();
	}

	translate([30, 100, 49]) {
		screw();
	}
}
