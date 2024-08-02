
include <./config.scad>
include <./grate.scad>

halfGrateMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, grateWidth - 160, 0]) halfGrateMeasuermentLinesWidth();
drawHalfGrateTopProjection();
