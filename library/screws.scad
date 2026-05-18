module nut($diameter) {
    linear_extrude(height = $diameter+1.1, convexity = 10, twist = 0)
    circle(d = $diameter, $fn = 6);
}

module screwHole($diameter, $length = 40) {
    translate([0, 0, -2]) cylinder(h = $length, d = $diameter + 1);
}
