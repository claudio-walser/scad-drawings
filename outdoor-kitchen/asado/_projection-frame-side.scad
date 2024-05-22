
include <./config.scad>

use <./frame.scad>
use <./spindleHole.scad>

frameMeasuermentLinesWidth();
rotate([0, 0, -90]) translate([0, outerDepth, 0]) frameMeasermentLinesHeight();
drawFrameSideProjection();
