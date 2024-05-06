include <./config.scad>

module spindle() {

    spindleLength = outerWidth - fireBasketWidth - (profileSize * 2) + spindleWallExtension + (spindleOverlength * 2);

    module partsList() {
        // Spindel
        echo(str("30;Spindel - Rundstahl;1;", spindleLength, ";", spindleDiameter, ";", spindleDiameter));

        // Spindelrad
        echo(str("31;Spindelrad - Irgendein Rad mit gegebnenem Durchmesser;1;", spindleWheelDiameter, ";;"));

        // Arretiermutter
        echo(str("32;Spindelrad - Mutter mit Durchmesser und Dicke ;1;", spindleDiameter * 2, ";", spindleDiameter , ";"));

        // TODO: flanges for metal strings
    }

    rotate([0, 90, 0]) {
        
        // Spindel
        cylinder(d = spindleDiameter, h = spindleLength);

        // Rad
        //cylinder(h=spindleDiameter, r=spindleWheelDiameter);

        // Aretiermutter
        //translate([0, 0, spindleDiameter])
        //cylinder(h=spindleDiameter, r=spindleDiameter, $fn = 6);


        // Zahnrad
        translate([0, 0, spindleDiameter + 12])
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
    }

    partsList();
}
