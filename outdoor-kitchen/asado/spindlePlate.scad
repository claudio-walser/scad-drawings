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
        // x, y, diameter
        radiiPoints=[
            [0,0,10],
            [0,handleLength,10],
            [20,handleLength,10],
            [20,handleWidth,100],
            [40,handleWidth,10],
            [40,0,10],
        ];

        difference() {
            linear_extrude(spindlePlateThickness)
            polygon(
              polyRound(radiiPoints,30)
            );

            translate([0, 40, - spindlePlateThickness/2])
            cylinder(h=spindlePlateThickness*2, d=spindleDiameter*2 + 2, $fn = 6);
        }

        // pin
        translate([7, 7, -(spindlePlateThickness+spindlePlateGap)])
        //translate([33, 7, -(spindlePlateThickness+2)])
        cylinder(h=spindlePlateThickness*2+spindlePlateGap, d=4);
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
    translate([0, -40, spindlePlateThickness + spindlePlateGap])
    handle();

    partsList();
}
