

// cover plate adafruit button
difference() {
    cube(size = [40, 40, 0.5], center = true);
    translate([0, 0, -8]) cylinder(d=11.6, h=10, $fn=100);
}





// cover plate default tactile button
translate([60,0,0])
difference() {
    cube(size = [40, 40, 0.5], center = true);
    translate([0, 0, -8]) cylinder(d=6.8, h=10, $fn=100);
}




// cover plate default button
translate([120,0,0])
difference() {
    cube(size = [40, 40, 0.5], center = true);
    translate([0, 0, -8]) cylinder(d=6.8, h=10, $fn=100);
}





// base plate adafruit button
translate([0,60,0]) {
    difference() {
        cube(size = [40, 40, 2], center = true);
        cube(size = [14, 11.8, 10], center = true);
    }

    difference() {
        translate([0, 0, -9.5]) cube(size = [11.8, 16, 2], center = true);
        translate([0, 4.5, -13]) cylinder(d=1.5, h=10, $fn=100);
        translate([0, -4.5, -13]) cylinder(d=1.5, h=10, $fn=100);
    }
    rotate([90, 0, 0]) translate([0, -5, -7]) cube(size = [11.8, 9, 2], center = true);
    rotate([90, 0, 0]) translate([0, -5, 7]) cube(size = [11.8, 9, 2], center = true);
}










// base plate default tactile button
translate([60,60,0]) {
    difference() {
        cube(size = [40, 40, 2], center = true);
        cube(size = [14, 11.8, 10], center = true);
    }

    translate([0, 0, -4]) cube(size = [11.8, 16, 2], center = true);

    rotate([90, 0, 0]) translate([0, -2, -7]) cube(size = [11.8, 4, 2], center = true);
    rotate([90, 0, 0]) translate([0, -2, 7]) cube(size = [11.8, 4, 2], center = true);
}





// base plate default button
translate([120,60,0]) {
    !difference() {
        cube(size = [40, 40, 2], center = true);
        translate([0, 0, -8]) cylinder(d=6.8, h=10, $fn=100);
    }

}