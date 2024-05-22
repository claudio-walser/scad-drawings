
include <./config.scad>

use <./fireBasket.scad>

//frameMeasuermentLinesWidth();
rotate([0, 0, -90])  translate([0, outerDepth + lineGap, 0]) fireBasketMeasermentLinesHeight();
drawFireBasketSideProjection();
