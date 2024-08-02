include <./config.scad>

module spindleGear() {

    // Zahnrad
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
        cylinder(d = spindleDiameter+0.1, h = 20);
    }
}

module spindleGearMeasuermentLinesLength() {
    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap + 20]);

        translate([100/2, -150, 0])
        square([lineThickness,lineGap + 20]);

        translate([100, 0, 0])
        square([lineThickness,lineGap + 20]);



        translate([-20, lineGap, 0]) {
            length = 100 + 40;

            translate([50, 15, 0])
            text(size = textSize, str(100));

            translate([50,-120, 0])
            text(size = textSize, str("Mittige Bohrung 20.1mm"));

            square([length, lineThickness]);
        }
    }
}

module spindleGearMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap + 20]);

        translate([100, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([-20, lineGap, 0]) {
            length = 100 + 40;

            translate([50, 15, 0])
            text(size = textSize, str(100));

            square([length, lineThickness]);
        }
    }
}


module drawSpindleGearTopProjection() {
    // // Draufsicht
    translate([100/2, -100/2, 0])
    projection() {
        rotate([0,0,180])
        spindleGear();
    }
}