include <./config.scad>

module spindleHandle() {

    module partsList() {
        // TODO: flanges for metal strings
    }


    module spindleHole() {

        translate([0, 0, -2]) {
            cylinder(d = spindleDiameter+0.1, h = spindleHandleThickness * 2);
            //translate([spindleDiameter * 0.75, 0, 0]) translate([-spindleDiameter/2, -spindleDiameter/2, -1]) cube([spindleDiameter, spindleDiameter, spindleHandleThickness]);
        }


    }

    difference() {
        translate([0, 0, -1])
        union() {
            hull() {
                cylinder(d = spindleDiameter * 1.5, h = spindleHandleThickness);
                translate([0, 80, 0]) cylinder(d = spindleDiameter, h = spindleHandleThickness);
            }
            //translate([0, 80, -80]) cylinder(d = 8, h = 80);
        }
        spindleHole();
        translate([0, 80, -10]) cylinder(d = 8.1, h = 80);
        translate([0, 0, -10]) cylinder(d= 4.2, h = 40);
    }

}


module drawSpindleHandleTopProjection() {
    // // Draufsicht
    translate([spindleDiameter*1.5/2, -spindleDiameter*1.5/2, 0])
    projection() {
        rotate([0,0,270])
        spindleHandle();
    }
}



module spindleHandleMeasuermentLinesLength() {
    color([0/255, 0/255, 0/255]) translate([0, 0, 0]) {

        square([lineThickness,lineGap * 2 + 20]);

        translate([15, 0, 0])
        square([lineThickness,lineGap + 20]);



        translate([15, -60, 0])
        square([lineThickness,lineGap + 20]);


        translate([95, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([95, -60, 0])
        square([lineThickness,lineGap + 20]);

        translate([105, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);




        translate([-20, lineGap * 2, 0]) {
            length = 105 + 40;

            translate([40, 15, 0])
            text(size = textSize, str(105));

            square([length, lineThickness]);
        }


        translate([-20, lineGap, 0]) {
            length = 105 + 40;

            translate([60, 15, 0])
            text(size = textSize, str(80));

            translate([5, 15, 0])
            text(size = textSize, str(15));

            translate([115, 15, 0])
            text(size = textSize, str(spindleDiameter/2));


            translate([-140,-160, 0])
            text(size = textSize, str("Bohrung 20.1mm"));


            translate([100,-160, 0])
            text(size = textSize, str("Bohrung 8.1mm"));

            square([length, lineThickness]);
        }

    }
}


module spindleHandleMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, 0, 0]) {

        translate([0, -230, 0])
        square([lineThickness,lineGap + 20]);


        translate([5, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([25, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([spindleDiameter*1.5, -230, 0])
        square([lineThickness,lineGap + 20]);


        translate([-20, -210, 0]) {
            length = 20 + 40;

            translate([20, 15, 0])
            text(size = textSize, str(spindleDiameter*1.5));

            square([length, lineThickness]);
        }


        translate([-20, lineGap, 0]) {
            length = 20 + 40;

            translate([15, 15, 0])
            text(size = textSize, str(spindleDiameter));

            square([length, lineThickness]);
        }

    }
}
