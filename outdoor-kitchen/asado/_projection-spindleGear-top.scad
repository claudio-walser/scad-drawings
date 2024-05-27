
include <./config.scad>
include <./spindleGear.scad>


spindleGearMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, 100, 0]) spindleGearMeasuermentLinesWidth();
drawSpindleGearTopProjection();
