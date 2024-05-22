
include <./config.scad>

use <./fireBasket.scad>

fireBasketMeasuermentLinesLength();
rotate([0, 0, -90])  translate([0, fireBasketWidth, 0]) fireBasketMeasermentLinesHeight();
drawFireBasketFrontProjection();
