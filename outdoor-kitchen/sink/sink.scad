
module sinkOuter() {
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
module sink() {
	difference() {
		sinkOuter();

		translate([0, 0, 5])
		hull() {
			translate([22, 22, 0])
			cylinder(r=20, h=300);

			translate([22, 448-20, 0])
			cylinder(r=20, h=300);


			translate([378, 22, 0])
			cylinder(r=20, h=300);

			translate([378, 448-20, 0])
			cylinder(r=20, h=300);
		}
	}
}