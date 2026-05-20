$fn = 256;

width = 100;
length = 200;
thickness = 8;

gaugeDiameter = 37.2;

difference() {
	cube([length, width, thickness]);

	translate([25, 15, -5])
	cube([length - 50, 6.5, thickness*2]);

	translate([25, 85 - 6.5, -5])
	cube([length - 50, 6.5, thickness*2]);

}

translate([length - 45 / 2 - 15, (width - 45) / 2 + 45/2, 0])
difference() {
	cylinder(d=45, h=20);
	translate([0, 0, -5]);
	cylinder(d=gaugeDiameter, h=30);

	translate([-30, -4.1, 11])
	cube([60, 8.2, 20]);
}


translate([length - 10, (width - 20) / 2, 0])
difference() {
	cube([5, 20, 16]);

	translate([-2, 10, 8 + 7.95/2 + 3.35])
	rotate([0, 90, 0])
	cylinder(d=7.95, h=10);
}


module nut($diameter) {
    linear_extrude(height = $diameter+1.1, convexity = 10, twist = 0)
    circle(d = $diameter, $fn = 6);
}

module screwHole($diameter, $length = 40) {
    translate([0, 0, -2]) cylinder(h = $length, d = $diameter + 1);
}



module nutSlider() {

	innerWidth = 19.4;
	outerWidth = 23.2;
	lipHeight = 6.5;
	height = 10.7;

	length = width;

	screwDiameter = 6;
	translate([30, 0, -8])
	difference() {
		union() {
			cube([innerWidth, length, height]);

			translate([-(outerWidth - innerWidth) / 2, 0, 0])
			cube([outerWidth, length, height - lipHeight]);
		}

		translate([innerWidth/2, 25 - 6.7, -7]) {
			nut((screwDiameter * 2) - 0.5);
			screwHole(screwDiameter);
		}

		translate([innerWidth/2, width - 25 + 6.7, -7]) {
			nut((screwDiameter * 2) - 0.5);
			screwHole(screwDiameter);
		}
	}

}

nutSlider();