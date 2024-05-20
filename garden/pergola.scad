module pergola() {
	floorWidth = 5250;
	floorLength = 3750;

	floorToPergolaOverlap = 20;

	pergolaWidth = floorWidth-floorToPergolaOverlap;
	pergolaLength = floorLength-floorToPergolaOverlap;

	thickness = 125;
	beamThickness = 170;
	roofThickness = 100;
	height = 2275;
	beamOverlap = 200;
	roofOverlap = 200;
	roofLeftOverlap = 500;
	roofGap = 200;
	roofToBeamOverlap = 100;
	outerWidth = pergolaWidth+beamOverlap+beamOverlap;

	woodMaxLenght = 4900;
	beamScarfLength = 300;
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
			translate([0, 110, height-685])
			rotate([45, 0, 0])
			cube(size=[thickness, 1000, thickness]);


			translate([pergolaLength-thickness, 110, height-685])
			rotate([45, 0, 0])
			cube(size=[thickness, 1000, thickness]);


			translate([pergolaLength, pergolaWidth, 0])
			rotate(180) {
				translate([0, 110, height-685])
				rotate([45, 0, 0])
				cube(size=[thickness, 1000, thickness]);


				translate([pergolaLength-thickness, 110, height-685])
				rotate([45, 0, 0])
				cube(size=[thickness, 1000, thickness]);
			}
		   echo(str("2;Kopfbänder ;", 4, ";", 1000, ";", thickness, ";", thickness));



			// beams
			//translate([0, -beamOverlap, height])
			//cube(size=[thickness, pergolaWidth+beamOverlap+beamOverlap, beamThickness]);

			//translate([pergolaLength-thickness, -beamOverlap, height])
			//cube(size=[thickness, pergolaWidth+beamOverlap+beamOverlap, beamThickness]);

			neededLenght = pergolaWidth+beamOverlap+beamOverlap;
			overlapAddition = (neededLenght - woodMaxLenght) / 2;

			beamEndPieces = overlapAddition + beamScarfLength;

			translate([0, -beamOverlap+overlapAddition, height])
			cube(size=[thickness, woodMaxLenght, beamThickness]);

			translate([pergolaLength-thickness, -beamOverlap+overlapAddition, height])
			cube(size=[thickness, woodMaxLenght, beamThickness]);


			// beam additions front
			// left
			translate([pergolaLength-thickness, -beamOverlap, height])
			#cube(size=[thickness, beamEndPieces, beamThickness]);

			translate([pergolaLength-thickness, pergolaWidth - beamEndPieces + beamOverlap, height])
			#cube(size=[thickness, beamEndPieces, beamThickness]);


			// beam additions back
			// left
			translate([0, -beamOverlap, height])
			#cube(size=[thickness, beamEndPieces, beamThickness]);

			translate([0, pergolaWidth - beamEndPieces + beamOverlap, height])
			#cube(size=[thickness, beamEndPieces, beamThickness]);


		   echo(str("3;Träger ;", 2, ";", woodMaxLenght, ";", thickness, ";", beamThickness));
		   echo(str("3;Trägerverlängerung ;", 4, ";", beamEndPieces, ";", thickness, ";", beamThickness));

			// roof
			amount = floor(outerWidth / (roofGap + 30)) - 1;
			realGap = (outerWidth - (amount * 30)) / (amount + 1);
			for ( i = [1 : amount] ) {
				currentOverlap = (i * realGap) - beamOverlap + (i * 30);
				translate([-roofOverlap, currentOverlap, height+90])
				cube(size=[pergolaLength+roofOverlap+roofLeftOverlap, 30, roofThickness]);
			}
		    echo(str("4;Dach ;", amount, ";", pergolaLength+roofOverlap+roofOverlap, ";", thickness, ";", 30));

		}
	}
}

pergola();