cube([40,40,4], center = true);

translate([0, 0, 20]) {    
    difference() {
        rotate([0, 90, 0])
        cube([40, 40, 8], center = true);
        
        translate([0, 20, 20])
        rotate([45, 0, 0])
        cube([40,40,40], center = true);

        translate([0, -15, 0])
        rotate([0, 90, 0])
        cylinder(d = 22, h=10, center=true);
        translate([0, -25, 0])
        cube([20, 20, 22], center = true);
    }
}
