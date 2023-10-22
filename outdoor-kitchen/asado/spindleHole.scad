include <./config.scad>

module spindleHole() {
    rotate([0, 90, 0]) {
        cylinder(d = spindleDiameter+0.5, h = outerWidth - fireBasketWidth - (profileSize * 2) + 20, $fn = 100);
    }
}