
include <./config.scad>

use <./frame.scad>
use <./spindleHole.scad>

measuermentLinesWidth();
rotate([0, 0, -90]) translate([0, outerDepth, 0]) measermentLinesHeight();
drawFrameSideProjection();
