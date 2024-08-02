
include <./config.scad>
include <./grateFrame.scad>

//use <./frame.scad>


collectingTrayMeasuermentLinesWidth();
rotate([0, 0, -90])  translate([0, trayWidth, 0]) collectingTrayMeasermentLinesHeight();
drawCollectingTraySideProjection();
