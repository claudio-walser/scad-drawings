include <./config.scad>

module spindleHole() {
    rotate([0, 90, 0]) {
        cylinder(d = spindleDiameter+2, h = outerWidth - fireBasketWidth - (profileSize * 2) + 20, $fn = 100);
    }
}