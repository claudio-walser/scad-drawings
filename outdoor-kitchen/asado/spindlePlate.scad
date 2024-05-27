include <./config.scad>
include <../../library/polyround.scad>

plateWidth = spindleDiameter * 10;
handleLength = spindleWheelDiameter + 150;
handleWidth = 60;


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

module lock() {
    difference() {
        hull() {
            cylinder(d = 10, h = spindleHandleThickness);

            translate([60, 0, 0])
            cylinder(d = 20, h = spindleHandleThickness);
        }
        translate([60, 0, -3])
        // pin hole
        cylinder(d = 6.2, h = 11.2);
    }
}

module drawSpindleLockTopProjection() {
    // // Draufsicht
    translate([70, -10, 0])
    projection() {
        rotate([0,0,180])
        lock();
    }
}

module spindleLockMeasuermentLinesLength() {
    color([0/255, 0/255, 0/255]) translate([0, 0, 0]) {

        square([lineThickness,lineGap * 2 + 20]);

        translate([10, 0, 0])
        square([lineThickness,lineGap + 20]);



        translate([10, -60, 0])
        square([lineThickness,lineGap + 20]);

        translate([75, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([-20, lineGap * 2, 0]) {
            length = 75 + 40;

            translate([40, 15, 0])
            text(size = textSize, str(75));

            square([length, lineThickness]);
        }


        translate([-20, lineGap, 0]) {
            length = 75 + 40;

            translate([40, 15, 0])
            text(size = textSize, str(65));

            translate([0, 15, 0])
            text(size = textSize, str(10));


            translate([10,-160, 0])
            text(size = textSize, str("Bohrung 6.2mm"));

            square([length, lineThickness]);
        }

    }
}


module spindleLockMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, 0, 0]) {

        translate([0, -230, 0])
        square([lineThickness,lineGap + 20]);


        translate([5, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([15, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([20, -230, 0])
        square([lineThickness,lineGap + 20]);


        translate([-20, -210, 0]) {
            length = 20 + 40;

            translate([15, 15, 0])
            text(size = textSize, str(20));

            square([length, lineThickness]);
        }


        translate([-20, lineGap, 0]) {
            length = 20 + 40;

            translate([15, 15, 0])
            text(size = textSize, str(10));

            square([length, lineThickness]);
        }

    }
}


module pin() {
    translate([60, 0, -2]) {
        difference() {
            union() {
                cylinder(d = 10, h = spindlePlateGap);
                cylinder(d = 6, h = spindleHandleThickness + spindlePlateGap + 0.2);
            }
             cylinder(d = 3.5, h = 30);
        }
    }
}

module pinHole() {
    translate([60, 0, -4]) {
        difference() {
            union() {
                cylinder(d = 10, h = 20);
            }
        }
    }
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

module onlySpindlePlate() {
    difference() {
        translate([-plateWidth/2, -plateWidth/2, 0])
        difference() {
            plate();
            screwHoles(15);
            spindleHole();




        }
     translate([50, 20, spindlePlateThickness + spindlePlateGap]) {
     rotate([0, 0, 70]) {
         translate([0, 0, -10]) pinHole();
     }}
    }
}

module spindlePlate() {

    onlySpindlePlate();

    translate([50, 20, spindlePlateThickness + spindlePlateGap]) {
        rotate([0, 0, 70]) {
            color([90/255, 50/255, 80/255]) lock();
            translate([0, 0, -spindlePlateGap + 2]) pin();
        }
    }
}
