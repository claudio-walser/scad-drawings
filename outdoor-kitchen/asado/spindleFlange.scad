include <./config.scad>

module spindleFlange(parts = false) {

    flangeGap = 0.5;
    drillSize = 5;

    module partsList() {
        // Spindelplatte
        echo(str("43;Flanschen - Rundstahl gedrechselt - Bohrung Madenschraube 4mm - Bohrung Stahlseil 4mm 15°/ 25°;2;", spindleDiameter*3, ";", spindleDiameter * 3, ";", spindleDiameter * 3));
    }


    difference() {
        // Körper
        union() {
            // Inner
            cylinder(d = spindleDiameter * 2, h = spindleDiameter * 3);
            // Outer
            cylinder(d = spindleDiameter * 3, h = spindleDiameter / 2);
        }

        // Spindel
        translate([0, 0, -spindleDiameter / 2])
        cylinder(h = spindleDiameter * 4, d = spindleDiameter + flangeGap);


        // Madenschraube
        rotate([0, 90, 0])
        translate([-spindleDiameter * 2, 0, -spindleDiameter - (spindleDiameter / 4)])
        cylinder(h = spindleDiameter, d = drillSize);

        // Befestigung Stahlseil
        translate([10, 31, spindleDiameter / 4 + 10])
        rotate([155, 75, 0])
        cylinder(h = spindleDiameter * 3, d = drillSize);

    }

    if (parts == true) {
        partsList();
    }
}
