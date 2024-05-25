
include <./config.scad>
include <./grate.scad>

halfGrateMeasuermentLinesLength();
rotate([0, 0, -90])  translate([0, halfGrateLength + lineGap, 0]) halfGrateMeasermentLinesHeight();
drawHalfGrateFrontProjection();
