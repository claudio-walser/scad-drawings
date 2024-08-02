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
                translate([0, 0, -spindlePlateThickness]) cylinder(d = 10, h = spindlePlateGap + spindlePlateThickness);
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
    cylinder(h=spindlePlateThickness*2, d=8);

    translate([gap, plateWidth - gap, - spindlePlateThickness / 2])
    cylinder(h=spindlePlateThickness*2, d=8);

    translate([plateWidth - gap, plateWidth - gap, - spindlePlateThickness / 2])
    cylinder(h=spindlePlateThickness*2, d=8);

    translate([plateWidth - gap, gap, - spindlePlateThickness / 2])
    cylinder(h=spindlePlateThickness*2, d=8);
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
            translate([0, 0, ]) pin();
        }
    }
}


module drawSpindlePlateTopProjection() {
    // // Draufsicht
    translate([plateWidth/2, -plateWidth/2, 0])
    projection() {
        rotate([0,0,90])
        onlySpindlePlate();
    }
}


module drawSpindlePlatePinSideProjection() {
    // // Draufsicht
    translate([-55, -8.2, 0])
    projection() {
        rotate([270,0,0])
        pin();
    }
}



module spindlePlatePinMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, lineGap/4, 0]) {

        square([lineThickness,lineGap + 10]);



        translate([2, 0, 0])
        square([lineThickness,lineGap/2 + 10]);
        translate([8, 0, 0])
        square([lineThickness,lineGap/2 + 10]);


        translate([10, 0, 0])
        square([lineThickness,lineGap + 10]);






        translate([5, -lineGap - 35, 2])
        square([lineThickness,lineGap + 10]);




        translate([-10, -lineGap, 0]) {


            translate([11, -45, 0])
            text(size = textSize/2, str("Mittige Gewindebohrung M4"));


        }




        translate([-10, lineGap/2, 0]) {
            length = 10 + 20;

            translate([11, 15, 0])
            text(size = textSize/2, str(6));

            translate([-2, 15, 0])
            text(size = textSize/2, str(2));

            translate([24, 15, 0])
            text(size = textSize/2, str(2));


            square([length, lineThickness]);
        }



        translate([-10, lineGap, 0]) {
            length = 10 + 20;

            translate([6, 15, 0])
            text(size = textSize/2, str(10));


            square([length, lineThickness]);
        }


    }
}


module spindlePlatePinMeasuermentLinesHeight() {
    color([0/255, 0/255, 0/255]) translate([0, -lineGap*2.2, 0]) {

        square([lineThickness,lineGap + 10]);



        translate([spindleHandleThickness + 0.2, 0, 0])
        square([lineThickness,lineGap/2 + 10]);



        translate([spindlePlateThickness + spindlePlateGap + spindleHandleThickness + 0.2, 0, 0])
        square([lineThickness,lineGap + 10]);



        translate([-10, lineGap/2, 0]) {
            length = 10 + 20;

            translate([18, 15, 0])
            text(size = textSize/2, str(spindlePlateThickness + spindlePlateGap));

            translate([-10, 15, 0])
            text(size = textSize/2, str(spindleHandleThickness + 0.2));



            square([length, lineThickness]);
        }



        translate([-10, lineGap, 0]) {
            length = 10 + 20;

            translate([6, 15, 0])
            text(size = textSize/2, str(spindlePlateThickness + spindlePlateGap + spindleHandleThickness + 0.2));


            square([length, lineThickness]);
        }


    }
}


module spindlePlateMeasuermentLinesLength() {
    color([0/255, 0/255, 0/255]) translate([0, lineGap, 0]) {

        square([lineThickness,lineGap * 2 + 20]);


        translate([15, 0, 0])
        square([lineThickness,lineGap + 20]);



        translate([plateWidth-15, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([plateWidth, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        //50, 20
        translate([23, -lineGap-30, 2])
        square([lineThickness,lineGap]);

        translate([0, -lineGap+10, 2])
        square([lineThickness,lineGap-40]);


        translate([plateWidth/2, -plateWidth - lineGap*2, 2])
        square([lineThickness,lineGap * 2 + 20]);


        translate([-20, -50, 0]) {
            length = 23 + 40;

            translate([15, 15, 0])
            text(size = textSize, str(23));


            translate([45, -20, 2])
            text(size = textSize, str("Bohrung 10.1mm"));

            square([length, lineThickness]);
        }



        translate([-20, lineGap * 2, 0]) {
            length = plateWidth + 40;

            translate([plateWidth/2, 15, 0])
            text(size = textSize, str(plateWidth));


            square([length, lineThickness]);



            translate([plateWidth/2, -plateWidth - lineGap*3 - plateWidth/2, 0])
            text(size = textSize, str("Mittige Bohrung 22mm"));

        }



        translate([-20, lineGap, 0]) {
            length = plateWidth + 40;

            translate([plateWidth/2, 15, 0])
            text(size = textSize, str(plateWidth - 15*2));


            translate([10, 15, 0])
            text(size = textSize, str(15));

            translate([plateWidth, 15, 0])
            text(size = textSize, str(15));

            translate([plateWidth + 40, 15, 0])
            text(size = textSize, str("Bohrungen Ecke 8mm"));


            square([length, lineThickness]);
        }


    }
}


module spindlePlateMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, lineGap, 0]) {

        translate([0, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        translate([15, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([plateWidth - 15, 0, 0])
        square([lineThickness,lineGap + 20]);



        translate([plateWidth, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([-20, lineGap * 2, 0]) {
            length = plateWidth + 40;

            translate([plateWidth/2, 15, 0])
            text(size = textSize, str(plateWidth));

            square([length, lineThickness]);
        }


        translate([-20, lineGap, 0]) {
            length = plateWidth + 40;

            translate([plateWidth/2, 15, 0])
            text(size = textSize, str(plateWidth - 15 * 2));


            translate([10, 15, 0])
            text(size = textSize, str(15));

            translate([plateWidth, 15, 0])
            text(size = textSize, str(15));

            square([length, lineThickness]);
        }




        //50, 20
        translate([29, -plateWidth-lineGap*2-20, 2])
        square([lineThickness,lineGap + 40]);

        translate([0, -plateWidth-lineGap*2-20, 2])
        square([lineThickness,lineGap]);

        translate([-20, -plateWidth-lineGap*2, 0]) {
            length = 23 + 40;

            translate([15, 15, 0])
            text(size = textSize, str(29));




            square([length, lineThickness]);
        }


    }
}