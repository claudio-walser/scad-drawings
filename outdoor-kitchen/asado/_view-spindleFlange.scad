
include <./config.scad>
include <./spindleFlange.scad>


color([200/255, 200/255, 100/255])
rotate([0, 90, 0])
translate([0, 0, -spindleDiameter * 3.5 - 3.33])
spindleFlange();
