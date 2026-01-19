// snow shovel
$fn=360;
difference() {
    difference() {
        cylinder(r=420, h=500);
        translate([0, 0, -5])
        cylinder(r=400, h=510);
    }

    translate([-380, -500, -5])
    cube([1000, 1000, 510]);
}