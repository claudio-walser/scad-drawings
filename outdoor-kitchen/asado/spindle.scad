include <./config.scad>

module spindle() {

    spindleLength = outerWidth - fireBasketWidth - (profileSize * 2) + spindleWallExtension + 20;

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
        cylinder(d = spindleDiameter, h = spindleLength, $fn = 100);
        
        // Rad
        cylinder(h=20, r=spindleWheelDiameter, $fn = 100);

        // Aretiermutter
        translate([0, 0, spindleDiameter])
        cylinder(h=spindleDiameter, r=spindleDiameter, $fn = 6);
    }

    partsList();
}
