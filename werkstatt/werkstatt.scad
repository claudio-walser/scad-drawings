$scaleFactor = 10;

$width = 3500;
$length = 4500;
$height = 2200;
$wallThickness = 150;





module room() {    
    translate([0, 0, $height / 2 + $wallThickness])
    difference() {
        cube(size = [$length + 2 * $wallThickness, $width + 2 * $wallThickness, $height + 2 * $wallThickness], center = true);
        translate([0, 0, $wallThickness]) cube(size = [$length, $width, $height + $wallThickness], center = true);
    }
}

scale([1 / $scaleFactor, 1 / $scaleFactor, 1 / $scaleFactor]) {
    room();
}
