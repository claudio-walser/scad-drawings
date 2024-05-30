
include <./config.scad>
include <./spindleFlange.scad>

spindleFlangeMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, 80, 0]) spindleFlangeMeasuermentLinesWidth();
drawSpindleFlangeSideProjection();
