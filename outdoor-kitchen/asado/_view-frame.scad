
include <./config.scad>

use <./frame.scad>
use <./spindleHole.scad>



color([65/255, 75/255, 95/255]) difference() {
	frame();

    translate([profileSize-spindleOverlength, outerDepth/2, outerHeight - profileSize - spindleDiameter - 20])
    #spindleHole();
}


// start csv header
framePartsList();