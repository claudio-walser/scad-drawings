floorWidth = 5250;
floorLength = 3750;

pergolaWidth = floorWidth-200;
pergolaLength = floorLength-200;

thickness = 150;
height = 2300;
beamOverlap = 200;
roofOverlap = 200;
roofGap = 80;
roofToBeamOverlap = 100;
// floor
cube(size=[floorLength, floorWidth, 10]);


translate([100, 100, 0]) {
	// supports
	cube(size=[thickness, thickness, height+thickness]);

	translate([pergolaLength-thickness, 0, 0])
	cube(size=[thickness, thickness, height+thickness]);

	translate([pergolaLength-thickness, pergolaWidth-thickness, 0])
	cube(size=[thickness, thickness, height+thickness]);

	translate([0, pergolaWidth-thickness, 0])
	cube(size=[thickness, thickness, height+thickness]);


	// 45 supports
	translate([0, 100, height-707])
	rotate([45, 0, 0])
	cube(size=[thickness, 1000, thickness]);


	translate([pergolaLength-thickness, 100, height-707])
	rotate([45, 0, 0])
	cube(size=[thickness, 1000, thickness]);


	translate([pergolaLength, pergolaWidth, 0])
	rotate(180, 0, 0) {
		translate([0, 100, height-707])
		rotate([45, 0, 0])
		cube(size=[thickness, 1000, thickness]);


		translate([pergolaLength-thickness, 100, height-707])
		rotate([45, 0, 0])
		cube(size=[thickness, 1000, thickness]);
	}



	// beams
	translate([0, -beamOverlap, height])
	cube(size=[thickness, pergolaWidth+beamOverlap+beamOverlap, thickness]);

	translate([pergolaLength-thickness, -beamOverlap, height])
	cube(size=[thickness, pergolaWidth+beamOverlap+beamOverlap, thickness]);


	// roof
	for ( i = [1 : 48] ){
		currentOverlap = (i * roofGap) - beamOverlap + (i*30);
		translate([-roofOverlap, currentOverlap, height+50])
		cube(size=[pergolaLength+roofOverlap+roofOverlap, 30, thickness]);
	}
}
