
include <./config.scad>

use <./fireBasket.scad>

fireBasketMeasuermentLinesLength();
rotate([0, 0, -90]) translate([0, fireBasketWidth - lineGap - profileSize/2, 0]) fireBasketMeasuermentLinesWidth();
drawFireBasketTopProjection();
