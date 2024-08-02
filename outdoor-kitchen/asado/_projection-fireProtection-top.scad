
include <./config.scad>

use <./fireBasket.scad>

fireProtectionMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, outerDepth, 0]) fireProtectionMeasuermentLinesWidth();
drawFireProtectionTopProjection();
