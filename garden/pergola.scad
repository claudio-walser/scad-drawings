//floorWidth = 5250;
//floorLength = 3750;

floorLength = 3615 + (2 * 125);
floorWidth = 4985 + (2 * 125);

floorToPergolaOverlap = 125;

height = 2275;

thickness = 125;
beamThickness = 170;
beamOverlap = 300;
roofThickness = 100;

roofOverlap = 200;
roofLeftOverlap = 625;
roofGap = 200;

pergolaWidth = floorWidth - floorToPergolaOverlap * 2;
pergolaLength = floorLength - floorToPergolaOverlap * 2;

module pergola() {

	beamLength = pergolaWidth + beamOverlap * 2;

	echo(str("Pergola Länge: ", pergolaWidth));
	echo(str("Pergola Breite: ", pergolaLength));

	// floor
	translate([0, 0, -10])
	cube(size=[floorLength, floorWidth, 10]);

	// supports
	// translate([floorToPergolaOverlap, floorToPergolaOverlap, 0])
	// cube(size=[thickness, thickness, height+thickness]);

	translate([floorLength - thickness - floorToPergolaOverlap, floorToPergolaOverlap, 0])
	cube(size=[thickness, thickness, height+thickness]);

	translate([floorToPergolaOverlap, floorWidth - thickness - floorToPergolaOverlap, 0])
	cube(size=[thickness, thickness, height+thickness]);

	translate([floorLength - thickness - floorToPergolaOverlap, floorWidth - thickness - floorToPergolaOverlap, 0])
	cube(size=[thickness, thickness, height+thickness]);

/*
	// beams
	translate([floorToPergolaOverlap, -beamOverlap + floorToPergolaOverlap, height])
	cube(size=[thickness, beamLength, beamThickness]);

	translate([pergolaLength - thickness + floorToPergolaOverlap, -beamOverlap + floorToPergolaOverlap, height])
	cube(size=[thickness, beamLength, beamThickness]);


	// 45 supports
	translate([floorToPergolaOverlap, 110 + floorToPergolaOverlap, height-685])
	rotate([45, 0, 0])
	cube(size=[thickness, 1000, thickness]);


	translate([pergolaLength - thickness + floorToPergolaOverlap, 110 + floorToPergolaOverlap, height-685])
	rotate([45, 0, 0])
	cube(size=[thickness, 1000, thickness]);


	translate([pergolaLength, pergolaWidth, 0])
	rotate(180) {
		translate([-floorToPergolaOverlap, 110 - floorToPergolaOverlap, height-685])
		rotate([45, 0, 0])
		cube(size=[thickness, 1000, thickness]);


		translate([pergolaLength - thickness - floorToPergolaOverlap, 110 - floorToPergolaOverlap, height-685])
		rotate([45, 0, 0])
		cube(size=[thickness, 1000, thickness]);
	}


	/*
	// roof
	translate([0, floorToPergolaOverlap, 0]) {
		amount = floor(beamLength / (roofGap + 30)) - 1;
		realGap = (beamLength - (amount * 30)) / (amount + 1);
		for ( i = [1 : amount] ) {
			currentOverlap = (i * realGap) - beamOverlap + (i * 30) - 30;
			translate([-roofLeftOverlap + floorToPergolaOverlap, currentOverlap, height+125])
			cube(size=[pergolaLength+roofOverlap+roofLeftOverlap, 30, roofThickness]);
		}
	}*/
}

