
include <./config.scad>
include <./grateFrame.scad>

grateFrameMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, grateLength, 0]) grateFrameMeasuermentLinesWidth();
drawGrateFrameTopProjection();
