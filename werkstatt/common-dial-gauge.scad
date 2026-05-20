$fn = 256;

width = 50;
length = 140;
thickness = 4;

gaugeDiameter = 37.2;

color("purple") {
	difference() {
		cube([length, width, thickness]);

		translate([10, (width - 6.5) / 2, -1])
		cube([length - 80, 6.5, thickness*2]);


	}

	translate([length - 45 / 2 - 10, (width - 45) / 2 + 45/2, 0])
	difference() {
		cylinder(d=45, h=thickness+12);
		translate([0, 0, -5]);
		cylinder(d=gaugeDiameter, h=30);

		translate([-30, -4.1, thickness+3])
		cube([60, 8.2, thickness+12]);
	}


	translate([length - 5, (width - 20) / 2, 0])
	difference() {
		cube([5, 20, thickness+8]);

		translate([-2, 10, thickness + 7.95/2 + 3.35])
		rotate([0, 90, 0])
		cylinder(d=7.95, h=10);
	}
}
