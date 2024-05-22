
include <./config.scad>

use <./fireBasket.scad>

fireBasketMeasuermentLinesWidth();
rotate([0, 0, -90])  translate([0, outerDepth + lineGap, 0]) fireBasketMeasermentLinesHeight();
drawFireBasketSideProjection();
