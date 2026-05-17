include <../library/screws.scad>
$fn = 256;

innerWidth = 19.4;
outerWidth = 23.2;
lipHeight = 5.8;
height = 10.2;

length = 25;

screwDiameter = 6;

difference() {
	union() {
		cube([innerWidth, length, height]);

		translate([-(outerWidth - innerWidth) / 2, 0, 0])
		cube([outerWidth, length, height - lipHeight]);
	}

	translate([innerWidth/2, length/2, -7]) {
		nut((screwDiameter * 2) - 0.5);
		screwHole(screwDiameter);
	}
}
