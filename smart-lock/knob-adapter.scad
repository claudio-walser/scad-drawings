$fn = 80;

//
// cube([41, 6, 35]);
module pin() {
    rotate([0, 0, 90])
    difference() {

        cylinder(h = 26, r = 4);
        translate([2, -10, -1])
        cube([2, 20, 28]);
    }
}

width = 41;
thickness = 6;
height = 35;

edgeRadius = 1;
difference() {
    translate([edgeRadius, edgeRadius, 0]) {
        hull() {
            cylinder(h = height, r = edgeRadius);
            
            translate([0, thickness - edgeRadius * 2, 0])
            cylinder(h = height, r = edgeRadius);


            translate([width - edgeRadius * 2, 0, 0]) { 
                cylinder(h = height, r = edgeRadius);
                
                translate([0, thickness - edgeRadius * 2, 0])
                cylinder(h = height, r = edgeRadius);
            }
        }
    }

    translate([3, (thickness - 2.1) / 2, 11])
    cube([35, 2.1, 26]);
    translate([20.5, 4.1, 11])
    pin();
}