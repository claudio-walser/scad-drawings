include <../../library/profiles.scad>
include <./config.scad>


grateLength = floor(outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4) - ((4 * grateProfileThickness)));
grateWidth = outerDepth - profileSize - (6 * grateProfileThickness);
halfGrateLength = floor((grateLength - grateProfileThickness) / 2);

startPos = 17;

module grateTemplate(grateLength = 400, grateWidth = 400, frontProjection = false) {
    // hinten
    if (frontProjection) {
        cube([grateLength, profileSize - 5, profileSize - 5]);
    } else {
        cube([grateLength, profileSize + 5, profileSize + 5]);
    }
    // vorne
    translate([0, grateWidth - profileSize + 10 - grateGap * 2, 0])
    cube([grateLength, profileSize - 5 , profileSize - 5]);
    
    if (frontProjection) {
        // rippen
        amount = round(grateLength / 35);
        echo(str("anzahl ", amount))
        for ( i = [0 : amount - 1] ) {
            translate([(i * 35) + startPos, 0, profileSize - 5])
            rotate([45, 0, 90])
            lShapeProfile(grateWidth + 30, 20, 2);
        }
    } else {
        // rippen
        amount = round(grateLength / 35);
        echo(str("anzahl ", amount))
        for ( i = [0 : amount - 1] ) {
            translate([(i * 35) + startPos, 0, profileSize + 5])
            rotate([45, 1, 90])
            lShapeProfile(grateWidth + 30, 20, 2);
        }
    }
}

module grate() {
    grateTemplate(grateLength, grateWidth);
}

module halfGrate(frontProjection = false) {
    grateTemplate(halfGrateLength, grateWidth, frontProjection);
}

module halfGratePartsList() {
    amount = round(halfGrateLength / 35);
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    // Träger
    echo(str("1,Vierkant Vorne", ",", "2", ",", halfGrateLength, ",", profileSize, ",", profileSize));
    echo(str("2,Vierkant Vorne", ",", "2", ",", halfGrateLength, ",", profileSize + 5, ",", profileSize + 5));
    // Rost
    echo(str("3,Winkel für Rost", ",", amount * 2, ",", grateWidth + 30, ",20,20"));

}


module drawHalfGrateFrontProjection() {

    // Vorne
    translate([halfGrateLength, -profileSize + 5, 0])
    projection() {
        rotate([90,0,180])
        halfGrate(frontProjection = true);
    }
}

module drawHalfGrateSideProjection() {
    translate([grateWidth + 30, -profileSize - 5, 0])
    // // Seite
    rotate([0,0,90])
    projection() {
        translate([0, 0, 0])
        rotate([0,90,0])
        halfGrate();
    }
}

module drawHalfGrateTopProjection() {
    // // Draufsicht
    translate([0, -grateWidth - 30, 0])
    projection() {
        rotate([0,0,0])
        halfGrate();
    }
}



module halfGrateMeasuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 60, 0]) {

        square([lineThickness,lineGap * 2 + 20]);

        translate([halfGrateLength, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        amount = round(halfGrateLength / 35);

        for ( i = [0 : amount - 1] ) {
            moveX = halfGrateLength - ((i * 35) + startPos);
            translate([moveX, 0, 0])
            //translate([halfGrateLength, 0, 0])
            square([lineThickness,lineGap + 20]);
        }


        translate([-20, lineGap * 2, 0]) {
            length = halfGrateLength + 40;

            translate([length / 2, 15, 0])
            text(size = textSize, str(halfGrateLength));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = halfGrateLength + 40;

            for ( i = [0 : amount - 1] ) {
                moveX = halfGrateLength - ((i * 35) + startPos);
                translate([moveX, 15, 0])
                if (i == 0) {
                    translate([24, 0, 0])
                    text(size = textSize, str(startPos));
                } else {
                    translate([24, 0, 0])
                    text(size = textSize, str(35));
                }
            }


            translate([5, 15, 0])
            text(size = textSize, str(startPos));

            square([length, lineThickness]);
        }

    }
}

module halfGrateMeasermentLinesHeight() {

    color([0/255, 0/255, 0/255])  {
        translate([0, 0, 0]) {

            translate([0, 0, 0])
            square([lineThickness, lineGap + 20]);

            translate([profileSize - 5, 0, 0])
            square([lineThickness, lineGap + 20]);

            // top line
            translate([-20, lineGap, 0]) {
                length = profileSize - 5 + 40;

                translate([22, 15, 0])
                text(size = textSize, str(profileSize - 5));

                square([length, lineThickness]);
            }

        }
    }
}

module halfGrateMeasermentLinesHeightBack() {

    color([0/255, 0/255, 0/255])  {
        translate([0, 0, 0]) {

            translate([0, 0, 0])
            square([lineThickness, lineGap + 20]);

            translate([profileSize + 5, 0, 0])
            square([lineThickness, lineGap + 20]);

            // top line
            translate([-20, lineGap, 0]) {
                length = profileSize - 5 + 40;

                translate([25, 15, 0])
                text(size = textSize, str(profileSize + 5));

                square([length, lineThickness]);
            }

        }
    }
}

module halfGrateMeasermentLinesHeightFront() {

    color([0/255, 0/255, 0/255])  {
        translate([0, 30, 0]) {

            translate([0, 0, 0])
            square([lineThickness, lineGap + 20]);

            translate([profileSize - 5, 0, 0])
            square([lineThickness, lineGap + 20]);

            // top line
            translate([-20, lineGap, 0]) {
                length = profileSize - 5 + 40;

                translate([25, 15, 0])
                text(size = textSize, str(profileSize - 5));

                square([length, lineThickness]);
            }

        }
    }
}


module halfGrateMeasuermentLinesWidth() {


    color([0/255, 0/255, 0/255]) translate([0, 60, 0]) {
        ribLength = grateWidth + 30;

        square([lineThickness,lineGap * 2 + 20]);


        translate([ribLength - (profileSize + 5), 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([ribLength - grateWidth + grateProfileThickness, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([ribLength - grateWidth + grateProfileThickness + (profileSize - 5), 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([ribLength, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([-20, lineGap * 2, 0]) {
            length = ribLength + 40;

            translate([ribLength / 2, 15, 0])
            text(size = textSize, str(ribLength));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = ribLength + 40;

            translate([55, 15, 0])
            text(size = textSize, str(profileSize - 5));

            translate([ribLength / 2, 15, 0])
            text(size = textSize, str(grateWidth - profileSize * 2 - grateProfileThickness));


            translate([20, 15, 0])
            text(size = textSize, str(30 +  grateProfileThickness));


            translate([ribLength - 15, 15, 0])
            text(size = textSize, str(profileSize + 5));

            square([length, lineThickness]);
        }

        //cube([33, 100, 33]);
    }
}