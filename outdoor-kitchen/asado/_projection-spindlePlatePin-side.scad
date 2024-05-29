
include <./config.scad>
include <./spindlePlate.scad>


spindlePlatePinMeasuermentLinesWidth();
rotate([0, 0, -90]) translate([0, plateWidth, 0]) spindlePlatePinMeasuermentLinesHeight();
drawSpindlePlatePinSideProjection();
