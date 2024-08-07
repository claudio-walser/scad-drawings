include <../../library/profiles.scad>
include <./config.scad>
include <./grate.scad>


grateFrameLength = outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4);
grateFrameWidth = outerDepth - profileSize - (2 * grateProfileThickness);
guidanceFrontDistance = (outerDepth - profileSize - 10 + 2) / 2;
guidanceBackDistance = grateFrameWidth - profileSize - 10 - guidanceFrontDistance;


trayThickness = 3;
trayWidth = 60;

module grateFrame() {

    translate([grateGap, 0, 0]) {
        // x (profileSize * 2) + grateGap
        // y profileSize + grateGap + grateProfileThickness
        // hinten
        lShapeProfile(grateFrameLength, grateSize, grateProfileThickness);

        // rechts
        rotate([90, 0, 90])
        lShapeProfile(grateFrameWidth, grateSize, grateProfileThickness);

        // links
        rotate([0, 0, 90])
        translate([0, -(grateFrameLength), 0])
        lShapeProfile(grateFrameWidth, grateSize, grateProfileThickness);

        // vorne
        translate([
            grateFrameLength,
            grateFrameWidth,
            0
        ])
        rotate([0, 0, 180])
        lShapeProfile(grateFrameLength, grateSize, grateProfileThickness);

        // Führungen seitlich
        translate([0, (grateFrameWidth / 2) - ((profileSize + 10) - 1), 0])
        rotate([0, 270, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, profileSize, 4);

        translate([grateFrameLength, (grateFrameWidth / 2) - ((profileSize + 10) - 1), fireBasketGroundClearance - 20])
        rotate([0, 90, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, profileSize, 4);

    }
}

module grateFramePartsList() {
    // TODO: draw the parts as in the part list, its messy right now, the list is correct
    // TODO: Second drilling in the middle of the height for hog roast
    // TODO: backholder for chickens or other stuff
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    // Träger
    echo(str("1,Vorne/Hinten - Gehrung", ",", "2", ",", grateFrameLength, ",", grateSize, ",", grateSize));
    echo(str("2,Seitlich - Gehrung", ",", "2", ",", grateFrameWidth, ",", grateSize, ",", grateSize));
    echo(str("3,Führungen - U-Profil", ",", "2", ",", fireBasketGroundClearance - 20, ",", profileSize + 10, ",", profileSize));
}

module grateFrameMeasuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap * 3 + 20]);

        translate([profileSize, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        translate([profileSize+ grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([grateFrameLength + profileSize - grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([grateFrameLength + profileSize, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([grateFrameLength + (profileSize) * 2, 0, 0])
        square([lineThickness,lineGap * 3 + 20]);


        translate([-20, lineGap * 3, 0]) {
            length = grateFrameLength + (profileSize + 10) * 2 + 40;

            translate([length / 2, 15, 0])
            text(size = textSize, str(grateFrameLength + (profileSize) * 2));

            square([length, lineThickness]);
        }

        translate([-20, lineGap * 2, 0]) {
            length = grateFrameLength + (profileSize + 10) * 2 + 40;

            translate([length / 2, 15, 0])
            text(size = textSize, str(grateFrameLength));

            translate([(profileSize + 10) / 2, 15, 0])
            text(size = textSize, str(profileSize));

            translate([grateFrameLength + profileSize + profileSize - 15, 15, 0])
            text(size = textSize, str(profileSize));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = grateFrameLength + (profileSize + 10) * 2 + 40;


            translate([(profileSize) + grateSize - 10, 15, 0])
            text(size = textSize, str(grateSize));

            translate([length / 2, 15, 0])
            text(size = textSize, str(grateFrameLength - grateSize * 2));

            translate([grateFrameLength + profileSize - 10, 15, 0])
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


    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap * 2 + 20]);

        translate([grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([guidanceFrontDistance + profileSize + 10, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([guidanceFrontDistance, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([grateFrameWidth - grateSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([grateFrameWidth, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([-20, lineGap * 2, 0]) {
            length = grateFrameWidth + 40;

            translate([outerDepth / 2, 15, 0])
            text(size = textSize, str(grateFrameWidth));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = grateFrameWidth + 40;

            translate([20, 15, 0])
            text(size = textSize, str(grateSize));

            translate([200, 15, 0])
            text(size = textSize, str(guidanceFrontDistance - grateSize));

            translate([outerDepth / 2 + 5, 15, 0])
            text(size = textSize, str(profileSize + 10));

            translate([grateFrameWidth - 10, 15, 0])
            text(size = textSize, str(grateSize));

            translate([outerDepth / 2 + 200, 15, 0])
            text(size = textSize, str(guidanceBackDistance - grateSize));

            // translate([20, -200, 0])
            // cube([guidanceFrontDistance, 10, 10]);
            // translate([20 + grateFrameWidth - guidanceBackDistance, -200, 0])
            // cube([guidanceBackDistance, 10, 10]);

            square([length, lineThickness]);
        }
    }
}

module drawGrateFrameFrontProjection() {

    // Vorne
    translate([grateFrameLength + profileSize, -fireBasketGroundClearance + 20, 0])
    projection() {
        rotate([90,0,180])
        grateFrame();
    }
}


module drawGrateFrameSideProjection() {
    translate([grateFrameWidth, -fireBasketGroundClearance + 20 , 0])
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
    translate([grateFrameLength + profileSize + 4, -grateFrameWidth, 0])
    projection() {
        rotate([180,0,180])
        grateFrame();
    }
}






module collectingTray() {

        uShapeProfile(grateFrameLength, trayWidth, trayWidth, trayThickness);

        cube([trayThickness, trayWidth, trayWidth]);

        translate([grateFrameLength - trayThickness, 0, 0])
        cube([trayThickness, trayWidth, trayWidth]);
}

module collectingTrayPartsList() {
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    // Träger
    echo(str("1,Vorne/Hinten", ",", "2", ",", grateFrameLength, ",", trayWidth, ",", trayThickness));
    echo(str("2,Unten", ",", "1", ",", grateFrameLength, ",", trayWidth, ",", trayThickness));
    echo(str("3,Seiten", ",", "2", ",", trayWidth, ",", trayWidth, ",", trayThickness));
}

module collectingTrayMeasuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap + 20]);

        translate([grateFrameLength, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([-20, lineGap, 0]) {
            length = grateFrameLength + 40;

            translate([grateFrameLength / 2, 15, 0])
            text(size = textSize, str(grateFrameLength));

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
    translate([grateFrameLength, -trayWidth, 0])
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
    translate([grateFrameLength, -trayWidth, 0])
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

module collectingTrayMountPartsList() {
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    // Halterung
    echo(str("1,Halterungen - Abwicklung", ",", "3", ",", trayWidth * 2 + trayWidth / 3 * 2 + trayThickness * 4 + 18, ",", trayWidth / 3, ",", trayThickness));
}

module collectingTrayMountMeasuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 60, 0]) {

        square([lineThickness,lineGap + 20]);

        translate([trayWidth / 3, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([-20, lineGap, 0]) {
            length = trayWidth / 3 + 40;

            translate([trayWidth / 3 / 2 + 5, 15, 0])
            text(size = textSize, str(trayWidth / 3));

            square([length, lineThickness]);
        }
    }
}

module collectingTrayMountMeasermentLinesHeight(extended = false) {

    color([0/255, 0/255, 0/255])  {
        translate([0, 50, 0]) {

            translate([0, 0, 0])
            square([lineThickness, lineGap + 20]);

            translate([trayWidth + trayThickness * 2, 0, 0])
            square([lineThickness, lineGap + 20]);

            if (extended) {
                translate([trayWidth / 3, 0, 0])
                square([lineThickness, lineGap + 20]);
            }

            // top line
            translate([-20, lineGap, 0]) {
                length = trayWidth + 40;


                if (extended) {
                    translate([trayWidth / 3 - 5, 15, 0])
                    text(size = textSize, str(trayWidth/3 + trayThickness));

                    translate([trayWidth - 10, 15, 0])
                    text(size = textSize, str(trayWidth - trayWidth/3 + trayThickness));

                    square([length, lineThickness]);

                } else {
                    translate([(trayWidth + 10) / 2, 15, 0])
                    text(size = textSize, str(trayWidth + trayThickness * 2));
                    square([length, lineThickness]);
                }
            }
        }
    }
}

module collectingTrayMountMeasuermentLinesWidth(extended = false) {
    color([0/255, 0/255, 0/255])  {
        translate([0, 50, 0]) {


            if (extended) {

                translate([0, 0, 0])
                square([lineThickness, lineGap * 2 + 20]);

                translate([trayWidth + trayThickness * 4, 0, 0])
                square([lineThickness, lineGap * 2 + 20]);



                translate([trayWidth + trayThickness * 3, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([trayWidth + trayThickness * 2, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([trayWidth + trayThickness, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([trayThickness, 0, 0])
                square([lineThickness, lineGap + 20]);


                // top line
                translate([-20, lineGap, 0]) {
                    length = trayWidth + trayThickness * 4 + 40;

                    translate([(25) / 2, 15, 0])
                    text(size = textSize, str(trayThickness));

                    translate([trayWidth + 25, 15, 0])
                    text(size = textSize, str(trayThickness));

                    translate([(trayWidth + 10) / 2, 15, 0])
                    text(size = textSize, str(trayWidth));

                    square([length, lineThickness]);
                }

                translate([-20, lineGap * 2, 0]) {
                    length = trayWidth + trayThickness * 4 + 40;

                    translate([(trayWidth + 10) / 2, 15, 0])
                    text(size = textSize, str(trayWidth + trayThickness * 4));

                    square([length, lineThickness]);
                }


            } else {

                translate([0, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([trayWidth + trayThickness * 4, 0, 0])
                square([lineThickness, lineGap + 20]);


                translate([0, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([trayWidth + trayThickness * 4, 0, 0])
                square([lineThickness, lineGap + 20]);

                // top line
                translate([-20, lineGap, 0]) {
                    length = trayWidth + trayThickness * 4 + 40;

                    translate([(trayWidth + 10) / 2, 15, 0])
                    text(size = textSize, str(trayWidth + trayThickness * 4));

                    square([length, lineThickness]);
                }
            }

        }
    }
}

module drawCollectingTrayMountFrontProjection() {
    // Vorne
    translate([trayWidth / 3, -trayWidth - trayThickness * 2, 0])
    projection() {
        rotate([90,0,180])
        collectingTrayMount();
    }
}

module drawCollectingTrayMountSideProjection() {
    translate([trayWidth + trayThickness, - trayWidth - trayThickness * 2, 0])
    // // Seite
    rotate([0,0,90])
    projection() {
        translate([0, 0, 0])
        rotate([0,90,0])
        collectingTrayMount();
    }
}

module drawCollectingTrayMountTopProjection() {
    // // Draufsicht
    translate([trayWidth / 3, -trayWidth-trayThickness, 0])
    projection() {
        rotate([180,0,180])
        collectingTrayMount();
    }
}
