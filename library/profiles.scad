module lShapeProfile($length, $size, $thickness) {
    cube([$length, $size, $thickness]);
    rotate([90, 0, 0])
    translate([0, 0, -$thickness]) cube([$length, $size, $thickness]);
}


module uShapeProfile($length, $width, $height, $thickness) {
    cube([$length, $width, $thickness]);
    rotate([90, 0, 0])
    translate([0, 0, -$thickness]) cube([$length, $height, $thickness]);

    translate([0, $width, 0])
    rotate([90, 0, 0])
    cube([$length, $height, $thickness]);
}


module squareTubeProfile($length, $size, $thickness) {
    cube([$length, $size, $thickness]);

    rotate([90, 0, 0])
    translate([0, 0, -$thickness])
    cube([$length, $size, $thickness]);

    translate([0, $size, 0])
    rotate([90, 0, 0])
    cube([$length, $size, $thickness]);

    translate([0, 0, $size - $thickness])
    cube([$length, $size, $thickness]);
}
