include <./config.scad>

module spindleGear() {

    module partsList() {
        // TODO: flanges for metal strings
    }

    // Zahnrad
    difference() {
        cylinder(d = 100, h = 8);

        translate([0, 0, -5])
        for ($angle = [0 : 18 : 360]) {

            hull() {
                rotate([0, 0, $angle]) translate([48, 0, -0.01])
                cylinder(d = 10, h = 20);

                rotate([0, 0, $angle]) translate([60, 0, -0.01])
                cylinder(d = 20, h = 20);
            }
        }
        translate([0, 0, -5])
        cylinder(d = spindleDiameter, h = 20);
    }

    partsList();
}
