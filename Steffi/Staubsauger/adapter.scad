$fn = 100;
difference() {
	cylinder( h=80,r=34.5);

	translate([0, 0, -5])
	cylinder( h=90,r=31.5);
}


translate([0, 0, 39]) {
	difference() {
		cylinder( h=2,r=34.5);

		translate([0, 0, -5])
		cylinder( h=12,r=29.5);
	}
}