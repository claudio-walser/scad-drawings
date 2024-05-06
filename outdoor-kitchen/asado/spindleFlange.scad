include <./config.scad>

module spindleFlange(parts = false) {

    flangeGap = 0.25;
    drillSize = spindleDiameter / 4;

    module partsList() {
        // Spindelplatte
        echo(str("43;Flanschen - Rundstahl gedrechselt - Bohrung Madenschraube ", drillSize , "mm - Bohrung Stahlseil ", drillSize , "mm 25°/ 25°;2;", spindleDiameter * 3, ";", spindleDiameter * 2, ";", spindleDiameter * 3));
    }

    rotate([0, 0,-90])
    difference() {
        // Körper
        union() {
            // Inner
            cylinder(d = spindleDiameter * 1.5, h = spindleDiameter * 3);
            // Outer
            cylinder(d = spindleDiameter * 2, h = spindleDiameter / 1.5);
            translate([0, 0, spindleDiameter * 3])
            cylinder(d = spindleDiameter * 2, h = spindleDiameter / 1.5);
        }

        // Spindel
        translate([0, 0, -spindleDiameter / 2])
        cylinder(h = spindleDiameter * 4, d = spindleDiameter + flangeGap);

        // Madenschraube und Aufnahme für Stahlseil
        translate([0, 0, spindleDiameter / 2]) {
            rotate([0, 90, 0])
            translate([-spindleDiameter * 2, 0, -spindleDiameter - (spindleDiameter / 4)])
            cylinder(h = spindleDiameter*3, d = drillSize);

            rotate([0, 90, 90])
            translate([-spindleDiameter * 2, 0, -spindleDiameter - (spindleDiameter / 5)])
            cylinder(h = spindleDiameter*3, d = drillSize);
        }
    }

    if (parts == true) {
        partsList();
    }
}
