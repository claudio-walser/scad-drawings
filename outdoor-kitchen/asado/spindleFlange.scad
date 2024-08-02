include <./config.scad>

    flangeGap = 0.25;
    drillSize = 6;
    screwSize = 4;

module spindleFlange(parts = false) {



    module partsList() {
        // Spindelplatte
        echo(str("43;Flanschen - Rundstahl gedrechselt - Bohrung Madenschraube ", drillSize , "mm - Bohrung Stahlseil ", drillSize , "mm 25°/ 25°;2;", spindleDiameter * 3, ";", spindleDiameter * 2, ";", spindleDiameter * 3));
    }

    rotate([0, 0,-90])
    difference() {
        // Körper
        union() {
            // Inner
            cylinder(d = spindleDiameter * 1.5, h = spindleDiameter * 3);
            // Outer
            cylinder(d = spindleDiameter * 2, h = spindleDiameter / 1.5);
            translate([0, 0, spindleDiameter * 3])
            cylinder(d = spindleDiameter * 2, h = spindleDiameter / 1.5);
        }

        // Spindel
        translate([0, 0, -spindleDiameter / 2 - spindleDiameter])
        cylinder(h = spindleDiameter * 6, d = spindleDiameter + flangeGap);

        // // Madenschraube und Aufnahme für Stahlseil
        // translate([0, 0, spindleDiameter / 2]) {

        //     // Bohrloch Fixierung
        //     rotate([0, 90, 0])
        //     translate([-spindleDiameter, 0, -spindleDiameter - (spindleDiameter / 4)])
        //     #cylinder(h = spindleDiameter, d = screwSize);

        //     // Aufnahme Stahlseil
        //     rotate([0, 90, 90])
        //     translate([-spindleDiameter * 2, 0, -spindleDiameter - (spindleDiameter / 5)])
        //     #cylinder(h = spindleDiameter*3, d = drillSize);
        // }
    }

    if (parts == true) {
        partsList();
    }
}


module drawSpindleFlangeTopProjection() {
    // // Draufsicht
    translate([spindleDiameter, -spindleDiameter, 0])
    projection() {
        rotate([0,0,0])
        spindleFlange();
    }
}

module drawSpindleFlangeSideProjection() {
    // // Draufsicht
    translate([0, -spindleDiameter, 0])
    projection() {
        rotate([0,90,0])
        spindleFlange();
    }
}


module spindleFlangeMeasuermentLinesLength() {
    color([0/255, 0/255, 0/255]) translate([0, 20, 0]) {

        square([lineThickness,lineGap*2 + 20]);

        translate([spindleDiameter / 1.5, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([spindleDiameter * 3, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([spindleDiameter * 3 + spindleDiameter / 1.5, 0, 0])
        square([lineThickness,lineGap*2 + 20]);


        translate([-20, lineGap*2, 0]) {
            length = spindleDiameter * 3 + spindleDiameter / 1.5 + 40;

            translate([length / 3 + 5, 15, 0])
            text(size = textSize, str(ceil(spindleDiameter * 3 + spindleDiameter / 1.5)));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = spindleDiameter * 3 + spindleDiameter / 1.5 + 40;


            translate([5, 15, 0])
            text(size = textSize, str(round(spindleDiameter / 1.5)));


            translate([length - 35, 15, 0])
            text(size = textSize, str(round(spindleDiameter / 1.5)));


            translate([length / 3 + 5, 15, 0])
            text(size = textSize, str(ceil(spindleDiameter * 3 + spindleDiameter / 1.5) - round(spindleDiameter/1.5) * 2 ));



            square([length, lineThickness]);
        }


        // translate([spindleDiameter * 3 + spindleDiameter / 1.5, -lineGap*2 - 20, 0])
        // square([lineThickness,lineGap + 20]);

        // translate([spindleDiameter * 2.5, -lineGap*2 - 40, 0])
        // #square([lineThickness,lineGap + 40]);



        // //translate([0, -lineGap*2 - 20, 0])
        // //square([lineThickness,lineGap + 20]);

        // translate([20, -lineGap*2, 0]) {
        //     length = spindleDiameter * 3 + spindleDiameter / 1.5;

        //     translate([length / 3 + 5, 15, 0])
        //     text(size = textSize, str(ceil(spindleDiameter * 3 + spindleDiameter / 1.5)));

        //     square([length, lineThickness]);
        // }


    }
}




module spindleFlangeMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, 20, 0]) {

        square([lineThickness,lineGap*2 + 20]);

        translate([spindleDiameter / 2, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([spindleDiameter + spindleDiameter / 2, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([spindleDiameter * 2, 0, 0])
        square([lineThickness,lineGap*2 + 20]);


        translate([-20, lineGap*2, 0]) {
            length = spindleDiameter * 2 + 40;

            translate([spindleDiameter + 5, 15, 0])
            text(size = textSize, str(spindleDiameter * 2));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = spindleDiameter * 2 + 40;

            translate([spindleDiameter + 5, 15, 0])
            text(size = textSize, str(spindleDiameter + 0.1));

            square([length, lineThickness]);
        }

    }
}