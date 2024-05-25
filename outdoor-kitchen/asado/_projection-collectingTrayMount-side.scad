
include <./config.scad>
include <./grateFrame.scad>

//use <./frame.scad>


collectingTrayMountMeasuermentLinesWidth(extended = true);
rotate([0, 0, -90])  translate([0, trayWidth, 0]) collectingTrayMountMeasermentLinesHeight(extended = true);
drawCollectingTrayMountSideProjection();
