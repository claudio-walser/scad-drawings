include <./config.scad>

module spindleFlange(parts = false) {

    flangeGap = 0.5;
    drillSize = 5;

    module partsList() {
        // Spindelplatte
        echo(str("43;Flanschen - Rundstahl gedrechselt - Bohrung Madenschraube 4mm - Bohrung Stahlseil 4mm 15°/ 25°;2;", spindleDiameter*3, ";", spindleDiameter * 3, ";", spindleDiameter * 3));
    }

    rotate([0, 0,-90])
    difference() {
        // Körper
        union() {
            // Inner
            cylinder(d = spindleDiameter * 1.5, h = spindleDiameter * 3);
            // Outer
            cylinder(d = spindleDiameter * 2, h = spindleDiameter / 2);
        }

        // Spindel
        translate([0, 0, -spindleDiameter / 2])
        cylinder(h = spindleDiameter * 4, d = spindleDiameter + flangeGap);


        // Madenschraube
        rotate([0, 90, 0])
        translate([-spindleDiameter * 2, 0, -spindleDiameter - (spindleDiameter / 4)])
        cylinder(h = spindleDiameter, d = drillSize);

        // Befestigung Stahlseil
        //translate([(spindleDiameter * 3)/2, 22, spindleDiameter / 4 + 5])
        translate([-spindleDiameter + (drillSize / 2), 0, spindleDiameter / 4 + drillSize / 2 + 1])
        rotate([270, 0, 0]) {
            // reference cylinder without rotation
            //cylinder(h = spindleDiameter * 3, d = drillSize);

            rotate([15, 25, 0])
            translate([0, 0, -spindleDiameter * 3])
            cylinder(h = spindleDiameter * 7, d = drillSize);
        }

    }

    if (parts == true) {
        partsList();
    }
}
