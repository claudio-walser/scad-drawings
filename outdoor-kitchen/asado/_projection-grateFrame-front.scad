
include <./config.scad>
use <./grateFrame.scad>

grateFrameMeasuermentLinesLength();
rotate([0, 0, -90])  translate([0, outerWidth, 0]) grateFrameMeasermentLinesHeight();
drawGrateFrameFrontProjection();
