module pergola() {
	floorWidth = 5250;
	floorLength = 3750;

	floorToPergolaOverlap = 100;

	pergolaWidth = floorWidth-floorToPergolaOverlap;
	pergolaLength = floorLength-floorToPergolaOverlap;

	thickness = 150;
	height = 2300;
	beamOverlap = 200;
	roofOverlap = 200;
	roofGap = 80;
	roofToBeamOverlap = 100;


	echo(str("Nr;Beschreibung;Stück;Länge;Breite;Höhe"));

	// floor
	cube(size=[floorLength, floorWidth, 10]);

	color([204/255, 138/255, 63/255]) {
		translate([floorToPergolaOverlap/2, floorToPergolaOverlap/2, 0]) {
			// supports
			cube(size=[thickness, thickness, height+thickness]);

			translate([pergolaLength-thickness, 0, 0])
			cube(size=[thickness, thickness, height+thickness]);

			translate([pergolaLength-thickness, pergolaWidth-thickness, 0])
			cube(size=[thickness, thickness, height+thickness]);

			translate([0, pergolaWidth-thickness, 0])
			cube(size=[thickness, thickness, height+thickness]);


		   echo(str("1;Stützen ;", 4, ";", height+thickness, ";", thickness, ";", thickness));


			// 45 supports
			translate([0, 110, height-707])
			rotate([45, 0, 0])
			cube(size=[thickness, 1000, thickness]);


			translate([pergolaLength-thickness, 110, height-707])
			rotate([45, 0, 0])
			cube(size=[thickness, 1000, thickness]);


			translate([pergolaLength, pergolaWidth, 0])
			rotate(180) {
				translate([0, 110, height-707])
				rotate([45, 0, 0])
				cube(size=[thickness, 1000, thickness]);


				translate([pergolaLength-thickness, 110, height-707])
				rotate([45, 0, 0])
				cube(size=[thickness, 1000, thickness]);
			}
		   echo(str("2;Verstärkungen ;", 4, ";", 1000, ";", thickness, ";", thickness));



			// beams
			translate([0, -beamOverlap, height])
			cube(size=[thickness, pergolaWidth+beamOverlap+beamOverlap, thickness]);

			translate([pergolaLength-thickness, -beamOverlap, height])
			cube(size=[thickness, pergolaWidth+beamOverlap+beamOverlap, thickness]);

		   echo(str("3;Träger ;", 2, ";", pergolaWidth+beamOverlap+beamOverlap, ";", thickness, ";", thickness));

			// roof
			for ( i = [1 : 49] ){
				currentOverlap = (i * roofGap) - beamOverlap + (i*30);
				translate([-roofOverlap, currentOverlap, height+50])
				cube(size=[pergolaLength+roofOverlap+roofOverlap, 30, thickness]);
			}
		   echo(str("4;Dach ;", 48, ";", pergolaLength+roofOverlap+roofOverlap, ";", thickness, ";", 30));

		}
	}
}