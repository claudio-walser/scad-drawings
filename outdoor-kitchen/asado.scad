include <./asado/config.scad>
include <./asado/frame.scad>
include <./asado/fireBasket.scad>
include <./asado/spindle.scad>
include <./asado/spindleHole.scad>
include <./asado/spindlePlate.scad>
include <./asado/spindleFlange.scad>


module reference() {
	// Referenz
	translate([0, 0 - outerDepth - 300, 0])
	cube(size = [outerWidth, outerDepth, outerHight]);
	translate([0 - outerWidth - 300, 0, 0])
	cube(size = [outerWidth, outerDepth, outerHight]);
}


//reference();

// start csv shizzle
echo(str("Nr;Beschreibung;Stück;Länge;Breite;Höhe"));
projectionGap = 200;



!drawFrameProjections();
framePartsList();

difference() {
	frame();

    translate([profileSize-spindleOverlength, outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
    spindleHole();
}

translate([profileSize-spindleWallExtension-spindleOverlength, outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
//color([0.5,0.5,0,0.2])
spindle();



translate([profileSize-spindleWallExtension-spindleOverlength + (spindleDiameter*2) + (spindlePlateThickness+spindlePlateGap), outerDepth / 2, outerHight - profileSize - spindleDiameter - 20])
rotate([0, -90, 0])
spindlePlate();




translate([profileSize * 2, outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
rotate([0, 90, 0])
spindleFlange(parts = true);

mirror([1,0,0]) {
    translate([profileSize * 2 - (outerWidth - fireBasketWidth), outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
    //translate([profileSize * 2, outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
    rotate([0, 90, 0])
    spindleFlange();
}

translate([outerWidth - fireBasketWidth, 0, fireBasketGroundClearance + profileSize])
fireBasket();
