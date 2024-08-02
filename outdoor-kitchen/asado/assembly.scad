include <./config.scad>
include <./frame.scad>
include <./fireBasket.scad>
include <./spindle.scad>
include <./spindleHole.scad>
include <./spindlePlate.scad>
include <./spindleFlange.scad>
include <./grateFrame.scad>
include <./grate.scad>

module asadoFull() {
	module reference() {
		// Referenz
		translate([0, 0 - outerDepth - 300, 0])
		color([255/255, 255/255, 255/255], 0.5) cube(size = [outerWidth, outerDepth, outerHeight]);
		translate([0 - outerWidth - 300, 0, 0])
		color([255/255, 255/255, 255/255], 0.5) cube(size = [outerWidth, outerDepth, outerHeight]);
	}

	module wallReference() {
		color([255/255, 255/255, 255/255]) translate([0, -spindleWallExtension, 0]) {
			// right wall
			translate([-spindleWallExtension, 0, 0]) cube(size = [spindleWallExtension, outerDepth + spindleWallExtension, outerHeight + spindleWallExtension]);

			// left wall
			translate([outerWidth, 0, 0]) cube(size = [spindleWallExtension, outerDepth + spindleWallExtension, outerHeight + spindleWallExtension]);


			// left wall
			translate([0, 0, 0]) cube(size = [outerWidth, spindleWallExtension, outerHeight + spindleWallExtension]);


		}
	}

	module fireBasketReference() {
		color([255/255, 255/255, 255/255], 0.5) translate([outerWidth - fireBasketWidth, 0, 0]) cube(size = [fireBasketWidth, outerDepth, outerHeight]);
	}

	if (drawReferences) {
		reference();
		fireBasketReference();
	}

	if (drawReferenceWall) {
		wallReference();
	}


	// start csv header
	echo(str("Nr;Beschreibung;Stück;Länge;Breite;Höhe"));
	framePartsList();

	color([65/255, 75/255, 95/255]) difference() {
		frame();

	    translate([profileSize-spindleOverlength, outerDepth/2, outerHeight - profileSize - spindleDiameter - 20])
	    spindleHole();
	}

	translate([-spindleWallExtension - (spindleOverlength * 2) - (spindlePlateThickness * 2) - (spindlePlateGap * 2), outerDepth/2, outerHeight - profileSize - spindleDiameter - 20])
	rotate([0, 90, 0]) {
		color([40/255, 255/255, 45/255]) spindle();
		spindleHandle();
	}

	translate([- spindleWallExtension, outerDepth / 2, outerHeight - profileSize - spindleDiameter - 20])
	rotate([0, -90, 0])
	spindlePlate();

	color([85/255, 95/255, 55/255]) translate([profileSize * 2, outerDepth/2, outerHeight - profileSize - spindleDiameter - 20])
	rotate([0, 90, 0])
	spindleFlange(parts = true);

	color([85/255, 95/255, 55/255]) mirror([1,0,0]) {
	    translate([profileSize * 2 - (outerWidth - fireBasketWidth), outerDepth/2, outerHeight - profileSize - spindleDiameter - 20])
	    //translate([profileSize * 2, outerDepth/2, outerHeight - profileSize - spindleDiameter - 20])
	    rotate([0, 90, 0])
	    spindleFlange();
	}

	color([75/255, 70/255, 255/255]) translate([outerWidth - fireBasketWidth, 0, fireBasketGroundClearance + profileSize])
	fireBasket();

	translate([(profileSize * 2) + grateGap, profileSize + grateGap + grateProfileThickness, fireBasketGroundClearance + 180]) {
		color([78/255, 5/255, 1/255]) grateFrame();

		// Aufangbehälter
		translate([grateProfileThickness + 1, grateWidth + grateProfileThickness, -trayWidth + grateSize])
		collectingTray();

		color([200/255, 200/255, 100/255]) {
			// translate([grateProfileThickness * 3 + 1, grateProfileThickness * 2, grateProfileThickness])
			// grate();

		    translate([grateProfileThickness * 3 + 1, grateProfileThickness * 2, grateProfileThickness])
		    halfGrate();

		    halfGrateLength = (outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4) - ((5 * grateProfileThickness))) / 2;
		    translate([grateProfileThickness * 4 + 1 + halfGrateLength, grateProfileThickness * 2, grateProfileThickness])
		    halfGrate();
		}
	}
}
