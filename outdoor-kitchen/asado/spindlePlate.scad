include <./config.scad>
include <../../library/polyround.scad>

module spindlePlate() {

    plateWidth = spindleDiameter * 10;
    handleLength = spindleWheelDiameter + 150;
    handleWidth = 60;

    module partsList() {
        // Spindelplatte
        echo(str("40;Spindelplatte - 4mm Blech - Ecken 2mm gerundet;1;", plateWidth, ";", plateWidth, ";", spindlePlateThickness));

        // Feststellgriff
        echo(str("41;Feststellgriff - 4mm Blech anhand der Zeichnung;1;", handleLength, ";", handleWidth, ";", spindlePlateThickness));

        // Pin als Achspunkt
        echo(str("42;Pin - Achspunkt für Griff - Rundstahl 4mm ;1;", spindlePlateThickness*2+spindlePlateGap, ";4;4"));

        // TODO: flanges for metal strings
    }



    module plate() {
        // x, y, diameter
        radiiPoints= [
            [0, 0, 2],
            [0, plateWidth, 2],
            [plateWidth, plateWidth, 2],
            [plateWidth, 0, 2]
        ];

        linear_extrude(spindlePlateThickness)
        polygon(
          polyRound(radiiPoints,30)
        );
    }

    module handle() {

    }

    module lock() {

        hull() {
            cylinder(d = 10, h = 8);

            translate([60, 0, 0])
            cylinder(d = 20, h = 8);
        }
        translate([60, 0, -3])
        cylinder(d = 10, h = 11.2);
    }

    module screwHoles(gap = 20) {
        translate([gap, gap, - spindlePlateThickness / 2])
        cylinder(h=spindlePlateThickness*2, d=8.2);

        translate([gap, plateWidth - gap, - spindlePlateThickness / 2])
        cylinder(h=spindlePlateThickness*2, d=8.2);

        translate([plateWidth - gap, plateWidth - gap, - spindlePlateThickness / 2])
        cylinder(h=spindlePlateThickness*2, d=8.2);

        translate([plateWidth - gap, gap, - spindlePlateThickness / 2])
        cylinder(h=spindlePlateThickness*2, d=8.2);
    }

    module spindleHole(gap = 20) {
        translate([plateWidth / 2, plateWidth / 2, - spindlePlateThickness / 2])
        cylinder(h=spindlePlateThickness*2, d=spindleDiameter + 2);
    }

    translate([-plateWidth/2, -plateWidth/2, 0])
    difference() {
       plate();
       screwHoles(15);
       spindleHole();
    }

    translate([50, 20, spindlePlateThickness + spindlePlateGap])
    rotate([0, 0, 70])
    color([90/255, 50/255, 80/255]) lock();

    partsList();
}
