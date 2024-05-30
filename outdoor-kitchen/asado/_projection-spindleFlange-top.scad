
include <./config.scad>
include <./spindleFlange.scad>

spindleFlangeMeasuermentLinesWidth();
//rotate([0, 0, -90]) translate([0, plateWidth, 0]) spindleFlangeMeasuermentLinesWidth();
drawSpindleFlangeTopProjection();
