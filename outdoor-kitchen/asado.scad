include <./asado/config.scad>
include <./asado/frame.scad>
include <./asado/spindle.scad>
include <./asado/spindleHole.scad>
include <./asado/spindlePlate.scad>
include <../library/roundedcube.scad>


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

translate([profileSize-spindleWallExtension-10, outerDepth/2, outerHight - profileSize - spindleDiameter - 20])
spindle();


roundedcube(3000, true, 700, "xmin");