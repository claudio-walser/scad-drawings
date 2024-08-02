
include <./config.scad>
include <./spindlePlate.scad>


spindleLockMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, 100, 0]) spindleLockMeasuermentLinesWidth();
drawSpindleLockTopProjection();
