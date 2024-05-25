
include <./config.scad>
include <./grateFrame.scad>

collectingTrayMountMeasuermentLinesLength();
rotate([0, 0, -90])  translate([0, trayWidth / 3, 0]) collectingTrayMountMeasermentLinesHeight();
drawCollectingTrayMountFrontProjection();
