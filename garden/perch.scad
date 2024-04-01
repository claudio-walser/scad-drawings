
cube(size=[6880, 2220, 10]);


thickness = 25;
depth = 100;

module perch(width = 1000, height = 2000) {

	//translate([0, depth*2, 0])
	//cube(size=[width, depth, height]);


	innerHeight = height - (2 * thickness);
	innerWidth = width - (2 * thickness);
	// left
	translate([0, 0, thickness])
	cube(size=[thickness, depth, innerHeight]);

	// right
	translate([width - thickness, 0, thickness])
	cube(size=[thickness, depth, innerHeight]);

	// bottom
	cube(size=[width, depth, thickness]);

	// top
	translate([0, 0, height - thickness])
	cube(size=[width, depth, thickness]);


	gap = 50;
	amount = innerHeight / (thickness + gap);
	translate([thickness, thickness, thickness])
	// inlays
	for ( i = [0 : amount - 1] ){
		translate([0, 0, (gap + thickness) * i])
		rotate([45, 0, 0])
		cube(size=[innerWidth, depth, thickness]);
	}

}



perch();
