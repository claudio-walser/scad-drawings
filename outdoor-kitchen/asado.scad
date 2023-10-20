include <./asado/config.scad>
include <./asado/frame.scad>
include <./asado/spindle.scad>
include <./asado/spindleHole.scad>
include <./asado/spindlePlate.scad>


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

difference() {
	frame();
	
    translate([profileSize-10, outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
    spindleHole();
}

translate([-125, outerDepth / 2, outerHight - profileSize - spindleDiameter - 20])
rotate([0, -90, 0])
!spindlePlate();

translate([profileSize-spindleWallExtension-10, outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
//color([0.5,0.5,0,0.2]) 
spindle();


