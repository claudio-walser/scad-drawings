
include <./config.scad>

use <./frame.scad>
use <./spindleHole.scad>

measuermentLinesLength();
rotate([0, 0, -90])  translate([0, outerWidth, 0]) measermentLinesHeight();
drawFrameFrontProjection();