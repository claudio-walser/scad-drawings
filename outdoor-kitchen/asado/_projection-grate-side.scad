
include <./config.scad>

use <./grate.scad>

halfGrateMeasuermentLinesWidth();
rotate([0, 0, -90]) translate([0, outerDepth, 0]) halfGrateMeasermentLinesHeightBack();
rotate([0, 0, 90]) translate([-profileSize - 5, 0, 0]) halfGrateMeasermentLinesHeightFront();
drawHalfGrateSideProjection();
