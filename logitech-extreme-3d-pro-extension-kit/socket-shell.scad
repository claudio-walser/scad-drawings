

module shell($outer_d, $inner_d, $height_d) {
    $fn = 300;

    difference() {
        cylinder(h = $height_d, d = $outer_d);
        translate([0, 0, -10]) cylinder(h = $height_d + 20, d = $inner_d);
    };
}

module notched_shell($outer, $inner, $height, $notch = 0) {
    if ($notch > 0) {
        difference() {
            shell($outer, $inner, $height);
            cylinder(h = $height, d = $outer);
            translate([-($notch/2), 0, -10]) cube([$notch, $outer, $height + 20]);
        };
    } else {
        shell($outer, $inner, $height);
    }
}



translate([0, 0, 0]) notched_shell(17, 15.5, 10, 0);
