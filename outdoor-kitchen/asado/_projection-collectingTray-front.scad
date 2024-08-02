
include <./config.scad>
include <./grateFrame.scad>

collectingTrayMeasuermentLinesLength();
rotate([0, 0, -90])  translate([0, grateLength + lineGap, 0]) collectingTrayMeasermentLinesHeight();
drawCollectingTrayFrontProjection();
