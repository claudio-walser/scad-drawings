include <./config.scad>
include <../../library/polyround.scad>

module spindlePlate() {

    plateWidth = spindleWheelDiameter - 50;

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
            [0,350,10],
            [20,350,10],
            [20,60,100],
            [40,60,10],
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
        cylinder(h=spindlePlateThickness*2, d=4);
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
    translate([0, -40, 10])
    handle();

}
