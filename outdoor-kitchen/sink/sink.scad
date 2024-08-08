
module sink() {
	hull() {
		translate([20, 20, 0])
		cylinder(r=20, h=300);

		translate([20, 450-20, 0])
		cylinder(r=20, h=300);


		translate([380, 20, 0])
		cylinder(r=20, h=300);

		translate([380, 450-20, 0])
		cylinder(r=20, h=300);
	}
}