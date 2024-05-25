
include <./config.scad>
include <./grateFrame.scad>

collectingTrayMountMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, trayThickness/3, 0]) collectingTrayMountMeasuermentLinesWidth();
drawCollectingTrayMountTopProjection();
