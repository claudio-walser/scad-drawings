
include <./config.scad>
include <./grateFrame.scad>

collectingTrayMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, grateLength, 0]) collectingTrayMeasuermentLinesWidth();
drawCollectingTrayTopProjection();
