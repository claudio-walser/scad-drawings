
include <./config.scad>
include <./spindlePlate.scad>


color([200/255, 200/255, 100/255])
rotate([0, 0, 180])
translate([-plateWidth/2, -plateWidth/2, 0])
onlySpindlePlate();
