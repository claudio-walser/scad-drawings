
module workbench(width = 1000, length = 1500, height = 1000, deskThickness = 80, legThickness = 80, overstandDesk = 50) {

    legInnerWidth = width - overstandDesk * 2 - legThickness * 2;
    legInnerLength = length - overstandDesk * 2 - legThickness * 2;
    legInnerHeight = height - deskThickness;

    module desk() {
        rotate([0, 0, 90]) translate([0, 0, deskThickness/2 + height - deskThickness]) cube(size = [width, length, deskThickness], center = true);
    }

    module legBase() {
        translate([-legInnerLength/2 - legThickness/2, 0, 0]) {
            leg();
            translate([legInnerLength+legThickness, 0, 0]) leg();
            
            // bottom right cross beam lenth
            rotate([0, 0, 90]) translate([-(legInnerWidth/2 + legThickness/2), -(legInnerLength/2 + legThickness/2), legThickness + legThickness/2]) cube(size=[legThickness, legInnerLength, legThickness], center = true);
            rotate([0, 0, 90]) translate([+(legInnerWidth/2 + legThickness/2), -(legInnerLength/2 + legThickness/2), legThickness + legThickness/2]) cube(size=[legThickness, legInnerLength, legThickness], center = true);
        }
    }

    module leg() {
        // bottom cross beam width
        translate([0, 0, legThickness + legThickness/2]) cube(size=[legThickness, legInnerWidth, legThickness], center = true);
        // top cross beam width
        translate([0, 0, legInnerHeight - legThickness*2 + legThickness/2]) cube(size=[legThickness, legInnerWidth, legThickness], center = true);

        // left leg
        translate([0, legInnerWidth/2 + legThickness/2, legInnerHeight/2]) cube(size=[legThickness, legThickness, legInnerHeight], center = true);
        // right leg
        translate([0, -(legInnerWidth/2 + legThickness/2), legInnerHeight/2]) cube(size=[legThickness, legThickness, legInnerHeight], center = true);
    }

    legBase();
    desk();
}

    workbench(
        width = 1000,
        length = 1500,
        height = 1000,
        deskThickness = 100,
        legThickness = 120,
        overstandDesk = 50
    );