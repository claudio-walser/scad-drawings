
include <./config.scad>
include <./grateFrame.scad>

grateFrameMeasuermentLinesLength();
rotate([0, 0, -90])  translate([0, grateLength + lineGap, 0]) grateFrameMeasermentLinesHeight();
drawGrateFrameFrontProjection();
