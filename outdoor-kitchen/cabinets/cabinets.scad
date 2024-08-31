frameBeamWidth = 80;
frameBeamThickness = 80;

grillFrameWidth = 1500 + 140 + 2 * frameBeamWidth;
grillFrameHeight = 960 + 700;

module cabinetFrame(length = 400, width = 880, height = 870 ) {
	color("peru") {
		// backward
		translate([0, 0, frameBeamWidth]) {
			cube([frameBeamWidth, frameBeamThickness, height - (frameBeamWidth * 2)]);

			translate([length - frameBeamWidth, 0, 0])
			cube([frameBeamWidth, frameBeamThickness, height - (frameBeamWidth * 2)]);

			// frontward
			translate([0, width - frameBeamThickness, 0]) {
				cube([frameBeamWidth, frameBeamThickness, height - (frameBeamWidth * 2)]);

				translate([length - frameBeamWidth, 0, 0])
				cube([frameBeamWidth, frameBeamThickness, height - (frameBeamWidth * 2)]);
			}
		}

		// lower
		// back
		cube([length, frameBeamThickness, frameBeamWidth]);

		// front
		translate([0, width - frameBeamThickness, 0])
		cube([length, frameBeamThickness, frameBeamWidth]);

		// left
		translate([0, frameBeamThickness, 0])
		cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);

		// right
		translate([length - frameBeamThickness, frameBeamThickness, 0])
		cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);



		// upper
		translate([0, 0, height - frameBeamWidth]) {
			// back
			cube([length, frameBeamThickness, frameBeamWidth]);

			// front
			translate([0, width - frameBeamThickness, 0])
			cube([length, frameBeamThickness, frameBeamWidth]);

			// left
			translate([0, frameBeamThickness, 0])
			cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);

			// right
			translate([length - frameBeamThickness, frameBeamThickness, 0])
			cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);
		}
	}


	// reference cube for size
	//cube([length, width, height]);
}


module firePitFrame(fireclay, fermacell, asado) {

	width = 880;

	color("lightgray") {
		// backward
		translate([0, 0, frameBeamWidth]) {
			cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);

			translate([grillFrameWidth - frameBeamWidth, 0, 0])
			#cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);


			// frontward
			translate([0, width - frameBeamWidth, 0]) {
				cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);

				translate([grillFrameWidth - frameBeamWidth, 0, 0])
				cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);
			}
		}

		// lower
		// back
		cube([grillFrameWidth, frameBeamWidth, frameBeamWidth]);

		// front
		translate([0, width - frameBeamWidth, 0])
		cube([grillFrameWidth, frameBeamWidth, frameBeamWidth]);

		// left
		translate([0, frameBeamWidth, 0])
		cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);

		// right
		translate([grillFrameWidth - frameBeamWidth, frameBeamWidth, 0])
		cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);




		// middle
		translate([0, 0, 500]) {
			// back
			translate([frameBeamWidth, 0, 0])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamWidth, frameBeamWidth]);

			// front
			translate([frameBeamWidth, width - frameBeamWidth, 0])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamWidth, frameBeamWidth]);

			// left
			translate([0, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);

			// right
			translate([grillFrameWidth - frameBeamWidth, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);


			// middle
			translate([(grillFrameWidth - frameBeamWidth) / 2, frameBeamWidth, frameBeamWidth / 2])
			cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);

			translate([frameBeamWidth * 1.5, frameBeamWidth, frameBeamWidth / 2])
			cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);

			translate([grillFrameWidth - frameBeamWidth * 2, frameBeamWidth, frameBeamWidth / 2])
			cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);


		}


		// middle top
		translate([0, 0, 660]) {
			// back
			translate([frameBeamWidth, 0, 0])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamWidth, frameBeamWidth]);

			// front
			translate([frameBeamWidth, width - frameBeamWidth, 0])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamWidth, frameBeamWidth]);

			// left
			translate([0, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);

			// right
			translate([grillFrameWidth - frameBeamWidth, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);


			translate([0, 0, -15]) {
				// middle
				translate([(grillFrameWidth - frameBeamWidth) / 2, frameBeamWidth, frameBeamWidth / 2])
				cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);



				// right
				translate([frameBeamWidth * 1.5, frameBeamWidth, frameBeamWidth / 2])
				cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);


				// right middle
				translate([grillFrameWidth / 4, frameBeamWidth, frameBeamWidth / 2])
				cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);

				// left middle
				translate([grillFrameWidth - grillFrameWidth / 4 - frameBeamWidth, frameBeamWidth, frameBeamWidth / 2])
				cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);


				// left
				translate([grillFrameWidth - frameBeamWidth * 2, frameBeamWidth, frameBeamWidth / 2])
				cube([frameBeamWidth / 2, width - (frameBeamWidth * 2), frameBeamWidth / 2]);
			}



		}


		// top
		translate([0, 0, grillFrameHeight - 2 * frameBeamWidth]) {

			// back
			translate([frameBeamWidth, 0, 60])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamThickness / 4, frameBeamWidth / 4]);


			translate([frameBeamWidth, 0, -200])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamThickness / 4, frameBeamWidth / 4]);


			translate([frameBeamWidth, 0, -460])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamThickness / 4, frameBeamWidth / 4]);

			translate([frameBeamWidth, 0, -720])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamThickness / 4, frameBeamWidth / 4]);

			// left
			translate([0, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);

			// left top
			translate([frameBeamWidth - frameBeamWidth / 4 - 15, frameBeamWidth, -frameBeamWidth / 4])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);

			translate([frameBeamWidth - frameBeamWidth / 4 - 15, frameBeamWidth, -200])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);

			translate([frameBeamWidth - frameBeamWidth / 4 - 15, frameBeamWidth, -460])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);

			// left bottom
			translate([frameBeamWidth - frameBeamWidth / 4 - 15, frameBeamWidth, -720])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);





			// right
			translate([grillFrameWidth - frameBeamWidth, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);

			// left top
			translate([grillFrameWidth - frameBeamWidth + 15, frameBeamWidth, -frameBeamWidth / 4])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);

			translate([grillFrameWidth - frameBeamWidth + 15, frameBeamWidth, -200])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);

			translate([grillFrameWidth - frameBeamWidth + 15, frameBeamWidth, -460])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);

			// left bottom
			translate([grillFrameWidth - frameBeamWidth + 15, frameBeamWidth, -720])
			cube([frameBeamWidth / 4, width - (frameBeamWidth * 2), frameBeamWidth / 4]);







		}

	}

	if (fermacell) {

		// fermacell
		color("green") {
			// back plate
			translate([frameBeamWidth, frameBeamWidth / 4, 660 + frameBeamWidth])
			cube([grillFrameWidth - (frameBeamWidth * 2), 15, 840]);


			// bottom plate
			translate([frameBeamWidth, frameBeamWidth, 660 + frameBeamWidth - 15])
			cube([grillFrameWidth - (frameBeamWidth * 2), width - (frameBeamWidth * 2), 15]);


			// right plate
			translate([frameBeamWidth-15, frameBeamWidth, 660 + frameBeamWidth])
			cube([15, width - (frameBeamWidth * 2), 840 - frameBeamWidth]);


			// left plate
			translate([grillFrameWidth-frameBeamWidth, frameBeamWidth, 660 + frameBeamWidth])
			cube([15, width - (frameBeamWidth * 2), 840 - frameBeamWidth]);


			// outer right
			translate([-15, 0, 660 + frameBeamWidth * 3])
			cube([15, width, 840 - frameBeamWidth * 2]);

			// outer left
			translate([grillFrameWidth, 0, 660 + frameBeamWidth * 3])
			cube([15, width, 840 - frameBeamWidth * 2]);


		}
	}

	if (fireclay) {
		// fireclay
		color("lightyellow") {
			// back plate
			translate([frameBeamWidth, frameBeamWidth / 4 + 15, 660 + frameBeamWidth])
			cube([grillFrameWidth - (frameBeamWidth * 2), 30, 840]);


			// bottom plate
			translate([frameBeamWidth, frameBeamWidth-15, 660 + frameBeamWidth])
			cube([grillFrameWidth - (frameBeamWidth * 2), width - frameBeamWidth + 15, 30]);


			// right plate
			translate([frameBeamWidth, frameBeamWidth - 15, 660 + frameBeamWidth+30])
			cube([30, width - (frameBeamWidth) + 15, 840 - frameBeamWidth+50]);


			//// left plate
			//translate([grillFrameWidth-frameBeamWidth, frameBeamWidth, 660 + frameBeamWidth])
			translate([grillFrameWidth-frameBeamWidth-30, frameBeamWidth - 15, 660 + frameBeamWidth+30])
			cube([30, width - (frameBeamWidth) + 15, 840 - frameBeamWidth+50]);

		}
	}
	if (asado) {
		translate([80 + 30 + 40, 30, 770])
		asadoFull();
	}
}

module firePitMeasurementsFront() {

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        #square([lineThickness,lineGap * 3 + 20]);

        translate([grillFrameHeight - frameBeamWidth, 0, 0])
        square([lineThickness,lineGap * 3 + 20]);


        translate([-20, lineGap * 3, 0]) {
            length = outerWidth + 40;

            translate([outerWidth / 2 + 190, 15, 0])
            text(size = textSize, str(outerWidth));

            square([length, lineThickness]);
        }

        translate([-20, lineGap * 2, 0]) {
            length = outerWidth + 40;

           translate([fireBasketWidth / 2, 15, 0])
            text(size = textSize, str(fireBasketWidth + profileSize));

            translate([outerWidth / 2 + 190, 15, 0])
            text(size = textSize, str(outerWidth - fireBasketWidth - (profileSize * 2)));

            translate([outerWidth - 15, 15, 0])
            text(size = textSize, str(profileSize));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = outerWidth + 40;

            translate([25, 15, 0])
            text(size = textSize, str(profileSize));

            translate([200, 15, 0])
            text(size = textSize, str(fireBasketWidth - profileSize));

            translate([fireBasketWidth + 25, 15, 0])
            text(size = textSize, str(profileSize));

            translate([fireBasketWidth + 65, 15, 0])
            text(size = textSize, str(profileSize));


            translate([outerWidth - 55, 15, 0])
            text(size = textSize, str(profileSize));

            translate([outerWidth / 2 + 200, 15, 0])
            text(size = textSize, str(outerWidth - fireBasketWidth - (profileSize * 4)));

            square([length, lineThickness]);
        }

    }
}