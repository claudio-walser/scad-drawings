$fn = 100;
module nut($diameter) {
    $fn = 6;
    linear_extrude(height = $diameter+1.1, convexity = 10, twist = 0)
    circle(d = $diameter);
}

module screwHole($diameter, $length = 40) {
    translate([0, 0, -2]) cylinder(h = $length, d = $diameter + 1);
}

module nutHolder() {
    difference() {
        difference() {
            translate([0, 0, 4]) cube([20,20,8], center = true);
            translate([0, 0, 2.6]) nut(11.4);
        };
        screwHole(6);
    }
}

module knob() {

    
    //rotate([0, 90, 0]) cylinder(d = 5, h = 200, center = true);

    difference() {
        minkowski() {
            translate([0, 0, 1])cylinder(14, 18, 18);
            rotate([0, 90, 0]) cylinder(d = 2);
        }
        
        screwHole(6);
        for ($angle = [0 : 60 : 360]) {
            rotate([0, 0, $angle]) translate([25, 0, -0.01]) cylinder(d = 20, h = 100 + 0.01);
        }
        translate([0, 0, 12.1]) cube([20.1, 20.1, 9], center = true);
    };
}



translate([40, 0, 0]) nutHolder();
translate([0, 0, 0]) knob();


