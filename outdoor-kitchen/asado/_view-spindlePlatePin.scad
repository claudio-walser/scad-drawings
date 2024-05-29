
include <./config.scad>
include <./spindlePlate.scad>


color([200/255, 200/255, 100/255])
rotate([0, 0, 180])
translate([-65, 5, spindlePlateThickness + spindlePlateGap])
pin();
