include <./asado/config.scad>
include <./asado/frame.scad>
include <./asado/fireBasket.scad>
include <./asado/spindle.scad>
include <./asado/spindleHole.scad>
include <./asado/spindlePlate.scad>
include <./asado/spindleFlange.scad>
include <./asado/grateFrame.scad>
include <./asado/grate.scad>


module reference() {
	// Referenz
	translate([0, 0 - outerDepth - 300, 0])
	cube(size = [outerWidth, outerDepth, outerHeight]);
	translate([0 - outerWidth - 300, 0, 0])
	cube(size = [outerWidth, outerDepth, outerHeight]);
}

module wallReference() {
	color([255/255, 255/255, 255/255], 0.5) cube(size = [spindleWallExtension, outerDepth, outerHeight]);
}

module fireBasketReference() {
	color([255/255, 255/255, 255/255], 0.5) cube(size = [fireBasketWidth, outerDepth, outerHeight]);
}


//reference();
//translate([-spindleWallExtension, 0, 0])
//wallReference();

//translate([outerWidth - fireBasketWidth, 0, 0])
//fireBasketReference();

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

color([78/255, 5/255, 1/255]) translate([(profileSize * 2) + grateGap, profileSize + grateGap + grateProfileThickness, fireBasketGroundClearance + 180]) {
	grateFrame();

    translate([grateProfileThickness * 2, grateProfileThickness * 2, 0])
    grate();
}

