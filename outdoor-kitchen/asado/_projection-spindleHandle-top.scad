
include <./config.scad>
include <./spindleHandle.scad>


spindleHandleMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, 120, 0]) spindleHandleMeasuermentLinesWidth();
drawSpindleHandleTopProjection();
