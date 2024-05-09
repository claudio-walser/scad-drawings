include <./config.scad>

module spindleHandle() {

    module partsList() {
        // TODO: flanges for metal strings
    }


    module spindleHole() {

        difference() {
            cylinder(d = spindleDiameter, h = spindleHandleThickness);
            translate([spindleDiameter * 0.75, 0, 0]) translate([-spindleDiameter/2, -spindleDiameter/2, -1]) cube([spindleDiameter, spindleDiameter, spindleHandleThickness]);
        }


    }

    difference() {
        translate([0, 0, -1])
        union() {
            hull() {
                cylinder(d = spindleDiameter * 1.5, h = spindleHandleThickness);
                translate([0, 80, 0]) cylinder(d = spindleDiameter, h = spindleHandleThickness);
            }
            translate([0, 80, -80]) cylinder(d = 8, h = 80);
        }
        spindleHole();
        translate([0, 0, -10]) cylinder(d= 4.2, h = 40);
    }

}
