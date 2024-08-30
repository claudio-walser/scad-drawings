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


module firePitFrame(length = 400, width = 880, height = 870) {

	color("lightgray") {
		// backward
		translate([0, 0, frameBeamWidth]) {
			cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);

			translate([grillFrameWidth - frameBeamWidth, 0, 0])
			cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);


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
			translate([(grillFrameWidth - frameBeamWidth) / 2, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);
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
		}


		// top
		translate([0, 0, grillFrameHeight - 2 * frameBeamWidth]) {
			// back
			translate([frameBeamWidth, 0, 0])
			cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamThickness, frameBeamWidth]);

			// front
			//translate([frameBeamWidth, width - frameBeamWidth, 0])
			//cube([grillFrameWidth - (frameBeamWidth * 2), frameBeamWidth, frameBeamWidth]);

			// left
			translate([0, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);

			// right
			translate([grillFrameWidth - frameBeamWidth, frameBeamWidth, 0])
			cube([frameBeamWidth, width - (frameBeamWidth * 2), frameBeamWidth]);
		}
	}

}