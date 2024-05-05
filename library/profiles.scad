module lShapeProfile($length, $size, $thickness) {
    cube([$length, $size, $thickness]);
    rotate([90, 0, 0])
    translate([0, 0, -$thickness]) cube([$length, $size, $thickness]);
}


module uShapeProfile($length, $size, $thickness) {
    cube([$length, $size, $thickness]);
    rotate([90, 0, 0])
    translate([0, 0, -$thickness]) cube([$length, $size, $thickness]);

    translate([0, $size, 0])
    rotate([90, 0, 0])
    cube([$length, $size, $thickness]);
}
