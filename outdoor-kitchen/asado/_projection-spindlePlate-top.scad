
include <./config.scad>
include <./spindlePlate.scad>


spindlePlateMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, plateWidth, 0]) spindlePlateMeasuermentLinesWidth();
drawSpindlePlateTopProjection();
