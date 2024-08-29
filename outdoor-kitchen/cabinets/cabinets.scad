frameBeamWidth = 80;
frameBeamThickness = 40;


module cabinetFrame(length = 400, width = 880, height = 870 ) {
	// backward
	translate([0, 0, frameBeamWidth]) {
		#cube([frameBeamWidth, frameBeamThickness, height - (frameBeamWidth * 2)]);

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
	#cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);

	// right
	translate([length - frameBeamThickness, frameBeamThickness, 0])
	#cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);



	// upper
	translate([0, 0, height - frameBeamWidth]) {
		// back
		cube([length, frameBeamThickness, frameBeamWidth]);

		// front
		translate([0, width - frameBeamThickness, 0])
		cube([length, frameBeamThickness, frameBeamWidth]);

		// left
		translate([0, frameBeamThickness, 0])
		#cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);

		// right
		translate([length - frameBeamThickness, frameBeamThickness, 0])
		#cube([frameBeamThickness, width - (frameBeamThickness * 2), frameBeamWidth]);
	}



	// reference cube for size
	//cube([length, width, height]);
}


module firePitFrame(length = 400, width = 880, height = 870) {
	grillFrameWidth = 1500 + 140;
	grillFrameHeight = 960 + 700;
	// backward
	translate([0, 0, frameBeamWidth]) {
		cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);

		translate([grillFrameWidth - frameBeamWidth, 0, 0])
		cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);





		// frontward
		translate([0, width - frameBeamThickness, 0]) {
			cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);

			translate([grillFrameWidth - frameBeamWidth, 0, 0])
			cube([frameBeamWidth, frameBeamWidth, grillFrameHeight - (frameBeamWidth * 2)]);
		}
	}
}