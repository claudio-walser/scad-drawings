include <../../library/profiles.scad>
include <./config.scad>
include <./grate.scad>


grateLength = outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4);
grateWidth = outerDepth - profileSize - (2 * grateProfileThickness);

trayThickness = 3;
trayWidth = 60;

module grateFrame() {

    translate([grateGap, 0, 0]) {
        // x (profileSize * 2) + grateGap
        // y profileSize + grateGap + grateProfileThickness
        // hinten
        lShapeProfile(grateLength, grateSize, grateProfileThickness);

        // rechts
        rotate([90, 0, 90])
        lShapeProfile(grateWidth, grateSize, grateProfileThickness);

        // links
        rotate([0, 0, 90])
        translate([0, -(grateLength), 0])
        lShapeProfile(grateWidth, grateSize, grateProfileThickness);

        // vorne
        translate([
            grateLength,
            grateWidth,
            0
        ])
        rotate([0, 0, 180])
        lShapeProfile(grateLength, grateSize, grateProfileThickness);

        // Führungen seitlich
        translate([0, (grateWidth / 2) - ((profileSize + 10) - 1), 0])
        rotate([0, 270, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, 4);

        translate([grateLength, (grateWidth / 2) - ((profileSize + 10) - 1), fireBasketGroundClearance - 20])
        rotate([0, 90, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, 4);

    }
}



module grateFramePartsList() {
    // TODO: draw the parts as in the part list, its messy right now, the list is correct
    // TODO: Second drilling in the middle of the height for hog roast
    // TODO: backholder for chickens or other stuff
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    // Träger
    echo(str("1,Vorne/Hinten - Gehrung", ",", "2", ",", grateLength, ",", grateSize, ",", grateSize));
    echo(str("2,Seitlich - Gehrung", ",", "2", ",", grateWidth, ",", grateSize, ",", grateSize));
    echo(str("3,Führungen", ",", "2", ",", fireBasketGroundClearance - 20, ",", profileSize + 10, ",", profileSize + 10));

}


module grateFrameMeasuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap * 3 + 20]);

        translate([profileSize + 10, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        translate([profileSize + 10 + grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([grateLength + profileSize + 10 - grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([grateLength + profileSize + 10, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([grateLength + (profileSize + 10) * 2, 0, 0])
        square([lineThickness,lineGap * 3 + 20]);


        translate([-20, lineGap * 3, 0]) {
            length = grateLength + (profileSize + 10) * 2 + 40;

            translate([length / 2, 15, 0])
            text(size = textSize, str(grateLength + (profileSize + 10) * 2));

            square([length, lineThickness]);
        }

        translate([-20, lineGap * 2, 0]) {
            length = grateLength + (profileSize + 10) * 2 + 40;

            translate([length / 2, 15, 0])
            text(size = textSize, str(grateLength));

            translate([(profileSize + 10) / 2, 15, 0])
            text(size = textSize, str(profileSize + 10));

            translate([grateLength + profileSize + profileSize, 15, 0])
            text(size = textSize, str(profileSize + 10));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = grateLength + (profileSize + 10) * 2 + 40;


            translate([(profileSize + 10) + grateSize - 10, 15, 0])
            text(size = textSize, str(grateSize));

            translate([length / 2, 15, 0])
            text(size = textSize, str(grateLength - grateSize * 2));

            translate([grateLength + profileSize, 15, 0])
            text(size = textSize, str(grateSize));




            square([length, lineThickness]);
        }

    }
}

module grateFrameMeasermentLinesHeight() {

        color([0/255, 0/255, 0/255])  {
            translate([0, 100, 0]) {

                translate([0, 0, 0])
                square([lineThickness, lineGap * 2 + 20]);

                translate([fireBasketGroundClearance - 20 -grateSize, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([fireBasketGroundClearance - 20, 0, 0])
                square([lineThickness, lineGap * 2 + 20]);


                // top line
                translate([-20, lineGap * 2, 0]) {
                    length = fireBasketGroundClearance - 20 + 40;

                    translate([(fireBasketGroundClearance - 20) / 2, 15, 0])
                    text(size = textSize, str(fireBasketGroundClearance - 20));

                    square([length, lineThickness]);
                }

                // middle line
                translate([-20, lineGap, 0]) {
                    length = fireBasketGroundClearance - 20 + 40;

                    translate([(fireBasketGroundClearance - 40) / 2, 15, 0])
                    text(size = textSize, str(fireBasketGroundClearance - 20 - grateSize));

                    translate([fireBasketGroundClearance - grateSize, 15, 0])
                    text(size = textSize, str(grateSize));

                    square([length, lineThickness]);
                }

            }
        }
}

module grateFrameMeasuermentLinesWidth() {
    guidanceFrontDistance = (outerDepth - profileSize - 10 + 2) / 2;
    guidanceBackDistance = grateWidth - profileSize - 10 - guidanceFrontDistance;

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap * 2 + 20]);

        translate([grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([guidanceFrontDistance + profileSize + 10, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([guidanceFrontDistance, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([grateWidth - grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([grateWidth, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([-20, lineGap * 2, 0]) {
            length = grateWidth + 40;

            translate([outerDepth / 2, 15, 0])
            text(size = textSize, str(grateWidth));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = grateWidth + 40;

            translate([20, 15, 0])
            text(size = textSize, str(grateSize));

            translate([200, 15, 0])
            text(size = textSize, str(guidanceFrontDistance - grateSize));

            translate([outerDepth / 2 + 5, 15, 0])
            text(size = textSize, str(profileSize + 10));

            translate([grateWidth - 10, 15, 0])
            text(size = textSize, str(grateSize));

            translate([outerDepth / 2 + 200, 15, 0])
            text(size = textSize, str(guidanceBackDistance - grateSize));

            // translate([20, -200, 0])
            // cube([guidanceFrontDistance, 10, 10]);
            // translate([20 + grateWidth - guidanceBackDistance, -200, 0])
            // cube([guidanceBackDistance, 10, 10]);

            square([length, lineThickness]);
        }
    }
}

module drawGrateFrameFrontProjection() {

    // Vorne
    translate([grateLength + profileSize + 10, -fireBasketGroundClearance + 20, 0])
    projection() {
        rotate([90,0,180])
        grateFrame();
    }
}


module drawGrateFrameSideProjection() {
    translate([grateWidth, -fireBasketGroundClearance + 20 , 0])
    // // Seite
    rotate([0,0,90])
    projection() {
        translate([0, 0, 0])
        rotate([0,90,0])
        grateFrame();
    }
}

module drawGrateFrameTopProjection() {
    // // Draufsicht
    translate([grateLength + profileSize + 10, -grateWidth, 0])
    projection() {
        rotate([180,0,180])
        grateFrame();
    }
}






module collectingTray() {

        uShapeProfile(grateLength, trayWidth, trayThickness);

        cube([trayThickness, trayWidth, trayWidth]);

        translate([grateLength - trayThickness, 0, 0])
        cube([trayThickness, trayWidth, trayWidth]);
}

module collectingTrayPartsList() {
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    // Träger
    echo(str("1,Vorne/Hinten", ",", "2", ",", grateLength, ",", trayWidth, ",", trayThickness));
    echo(str("2,Unten", ",", "1", ",", grateLength, ",", trayWidth, ",", trayThickness));
    echo(str("3,Seiten", ",", "2", ",", trayWidth, ",", trayWidth, ",", trayThickness));
}

module collectingTrayMeasuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap + 20]);

        translate([grateLength, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([-20, lineGap, 0]) {
            length = grateLength + 40;

            translate([grateLength / 2, 15, 0])
            text(size = textSize, str(grateLength));

            square([length, lineThickness]);
        }
    }
}

module collectingTrayMeasermentLinesHeight() {

    color([0/255, 0/255, 0/255])  {
        translate([0, 50, 0]) {

            translate([0, 0, 0])
            square([lineThickness, lineGap + 20]);

            translate([trayWidth, 0, 0])
            square([lineThickness, lineGap + 20]);

            // top line
            translate([-20, lineGap, 0]) {
                length = trayWidth + 40;

                translate([(trayWidth + 10) / 2, 15, 0])
                text(size = textSize, str(trayWidth));

                square([length, lineThickness]);
            }
        }
    }
}

module collectingTrayMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255])  {
        translate([0, 50, 0]) {

            translate([0, 0, 0])
            square([lineThickness, lineGap + 20]);

            translate([trayWidth, 0, 0])
            square([lineThickness, lineGap + 20]);

            // top line
            translate([-20, lineGap, 0]) {
                length = trayWidth + 40;

                translate([(trayWidth + 10) / 2, 15, 0])
                text(size = textSize, str(trayWidth));

                square([length, lineThickness]);
            }
        }
    }
}

module drawCollectingTrayFrontProjection() {

    // Vorne
    translate([grateLength, -trayWidth, 0])
    projection() {
        rotate([90,0,180])
        collectingTray();
    }
}

module drawCollectingTraySideProjection() {
    translate([trayWidth, - trayWidth, 0])
    // // Seite
    rotate([0,0,90])
    projection() {
        translate([0, 0, 0])
        rotate([0,90,0])
        collectingTray();
    }
}


module drawCollectingTrayTopProjection() {
    // // Draufsicht
    translate([grateLength, -trayWidth, 0])
    projection() {
        rotate([180,0,180])
        collectingTray();
    }
}












module collectingTrayMount() {
        translate([0, -trayThickness, 0])
        cube([trayWidth / 3, trayWidth + trayThickness * 2, trayThickness]);

        translate([0, -trayThickness, 0])
        cube([trayWidth / 3,  trayThickness,  trayWidth + trayThickness * 2]);

        translate([0, trayWidth, 0])
        cube([trayWidth / 3,  trayThickness,  trayWidth  / 3]);

        translate([0, -trayThickness * 3, trayWidth + trayThickness])
        cube([trayWidth / 3,  trayThickness * 3,  trayThickness]);

        translate([0, -trayThickness * 3, trayWidth - trayWidth / 3 + trayThickness * 2])
        cube([trayWidth / 3,  trayThickness,  trayWidth / 3]);
}