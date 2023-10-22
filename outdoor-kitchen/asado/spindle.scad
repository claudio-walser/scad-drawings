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
        translate([0, 0, spindleDiameter])
        cylinder(h=spindleDiameter, r=spindleDiameter, $fn = 6);

    }

    partsList();
}
