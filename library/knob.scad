include <./screws.scad>

module nutHolder(screwDiameter = 6) {
    difference() {
        difference() {
            translate([0, 0, 4]) cube([20,20,8], center = true);
            translate([0, 0, 2.6]) nut((screwDiameter * 2) - 0.5);
        };
        screwHole(screwDiameter);
    }
}

module knob(screwHole = false, screwDiameter = 6) {

    
    //rotate([0, 90, 0]) cylinder(d = 5, h = 200, center = true);

    difference() {
        minkowski() {
            translate([0, 0, 1]) cylinder(14, 18, 18);
            rotate([0, 90, 0]) cylinder(d = 2);
        }
        
        if (screwHole) {
            screwHole(screwDiameter);
        }
        for ($angle = [0 : 60 : 360]) {
            rotate([0, 0, $angle]) translate([25, 0, -0.01]) cylinder(d = 20, h = 100 + 0.01);
        }
        translate([0, 0, 12.1]) cube([20.1, 20.1, 9], center = true);
    };
}