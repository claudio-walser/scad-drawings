include <./config.scad>
include <../../library/profiles.scad>

module frame() {
    // Rahmen
    // Fuss rechts Hinten
    cube(size = [profileSize, profileSize, fireBasketGroundClearance]);

    // Fuss rechts Vorne
    translate([0, outerDepth - profileSize, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance]);

    // Fuss links Hinten
    translate([outerWidth - profileSize, 0, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance + profileSize + profileSize + fireBasketHeight]);

    // Fuss links Vorne
    translate([outerWidth - profileSize, outerDepth - profileSize, 0])
    cube(size = [profileSize, profileSize, fireBasketGroundClearance + profileSize + profileSize + fireBasketHeight]);

    // Fuss mitte Hinten
    translate([outerWidth - profileSize - fireBasketWidth, 0, fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, profileSize + profileSize + fireBasketHeight]);

    // Fuss mitte Vorne
    translate([outerWidth - profileSize - fireBasketWidth, outerDepth - profileSize, fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, profileSize + profileSize + fireBasketHeight]);


    // Profil Hinten
    translate([0, 0, fireBasketGroundClearance])
    cube(size = [outerWidth, profileSize, profileSize]);

    // Profil Rechts
    translate([0, 0, fireBasketGroundClearance])
    cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Mitte
    translate([outerWidth - profileSize - fireBasketWidth, 0, fireBasketGroundClearance])
    cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Mitte Oben
    translate([outerWidth - profileSize - fireBasketWidth, 0, fireBasketGroundClearance + profileSize + fireBasketHeight])
    cube(size = [profileSize, outerDepth, profileSize]);


    // Profil Links
    translate([outerWidth - profileSize, 0, fireBasketGroundClearance])
    cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Links Oben
    translate([outerWidth - profileSize, 0, fireBasketGroundClearance + profileSize + fireBasketHeight])
    cube(size = [profileSize, outerDepth, profileSize]);

    // Profil Vorne
    translate([outerWidth - fireBasketWidth, outerDepth - profileSize, fireBasketGroundClearance])
    cube(size = [fireBasketWidth, profileSize, profileSize]);

    // Profil Steg Mitte
    //translate([outerWidth - fireBasketWidth, (outerDepth/2) - (profileSize/2), fireBasketGroundClearance])
    //cube(size = [fireBasketWidth, profileSize, profileSize]);


    // Träger
    translate([profileSize, (outerDepth/2) - (profileSize/2), outerHeight - profileSize])
    cube(size = [outerWidth - fireBasketWidth - (profileSize * 2), profileSize, profileSize]);

    // Stütze Rechts
    translate([profileSize, (outerDepth/2) - (profileSize/2), fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, outerHeight - fireBasketGroundClearance]);

    // Stütze Links
    translate([outerWidth - fireBasketWidth - (profileSize * 2), (outerDepth/2) - (profileSize/2), fireBasketGroundClearance])
    cube(size = [profileSize, profileSize, outerHeight - fireBasketGroundClearance]);

    // Halter
    distance = (outerWidth - fireBasketWidth - (profileSize * 2)) / 5 + 10;
    translate([0, -30, 0])
    rotate([-15, 0, 0])
    translate([20, 0, fireBasketGroundClearance + profileSize]) {
        translate([distance * 1, 0, 0])
        rotate([0, -90, 0])
        squareTubeProfile(profileSize, 20, 2);

        translate([distance * 2, 0, 0])
        rotate([0, -90, 0])
        squareTubeProfile(profileSize, 20, 2);

        translate([distance * 3, 0, 0])
        rotate([0, -90, 0])
        squareTubeProfile(profileSize, 20, 2);

        translate([distance * 4, 0, 0])
        rotate([0, -90, 0])
        squareTubeProfile(profileSize, 20, 2);
    }

}

module framePartsList() {
    // TODO: draw the parts as in the part list, its messy right now, the list is correct
    // TODO: Second drilling in the middle of the height for hog roast
    // TODO: backholder for chickens or other stuff
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    // Träger
    echo(str("1,Träger - Gehrung beidseitig", ",", "1", ",", outerWidth - fireBasketWidth - (profileSize * 2), ",", profileSize, ",", profileSize));
    // Stützen
    echo(str("2,Stützen - Gehrung einseitig / 22mm Bohrung für Spindel", ",", "2", ",", outerHeight, ",", profileSize, ",", profileSize));

    // Füsse
    echo(str("3,Fuss Rechts Hinten - Stumpf", ",", "1", ",", fireBasketGroundClearance, ",", profileSize, ",", profileSize));
    echo(str("4,Fuss Rechts Vorne - Gehrung einseitig", ",", "1", ",", fireBasketGroundClearance + profileSize, ",", profileSize, ",", profileSize));

    // Rahmen rechts
    echo(str("6,Rahmen rechts - Gehrung beidseit / Gehrung einmal 90° gedreht für Fuss", ",", "1", ",", outerDepth, ",", profileSize, ",", profileSize));

    // Rahmen hinten
    echo(str("7,Rahmen hinten - Gehrung einseitig", ",", "1", ",", outerWidth - fireBasketWidth - profileSize, ",", profileSize, ",", profileSize));

    // Korbhalter
    // Füsse lang
    echo(str("8,Füsse Links - Gehrung einseitig", ",", "2", ",", fireBasketGroundClearance + profileSize + profileSize + fireBasketHeight, ",", profileSize, ",", profileSize));
    // Füsse kurz
    echo(str("9,Füsse Mitte - Gehrung beidseitig", ",", "2", ",", profileSize + profileSize + fireBasketHeight, ",", profileSize, ",", profileSize));
    // Querstreben Gehrung
    echo(str("10,Querstreben lang - Gehrung beidseitig", ",", "3", ",", outerDepth, ",", profileSize, ",", profileSize));
    // Querstrebe Stumpf
    echo(str("11,Querstrebe kurz - Stumpf", ",", "1", ",", outerDepth - (profileSize * 2), ",", profileSize, ",", profileSize));
    // Stege
    echo(str("12,Stege kurz - Stumpf", ",", "2", ",", outerDepth - (profileSize * 2), ",", profileSize, ",", profileSize));


    // Aufnahmen Grillstangen
    echo(str("12,Aufnahmen Grillstangen / 15° schräg", ",", "4", ",", profileSize, ",", 20, ",", 20));

}

module measuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap * 3 + 20]);

        translate([profileSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([fireBasketWidth, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([fireBasketWidth + profileSize, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        translate([fireBasketWidth + profileSize * 2, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([outerWidth - profileSize, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        translate([outerWidth - profileSize * 2, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([outerWidth, 0, 0])
        square([lineThickness,lineGap * 3 + 20]);


        translate([-20, lineGap * 3, 0]) {
            length = outerWidth + 40;

            translate([outerWidth / 2 + 190, 15, 0])
            text(size = textSize, str(outerWidth));

            square([length, lineThickness]);
        }

        translate([-20, lineGap * 2, 0]) {
            length = outerWidth + 40;

           translate([fireBasketWidth / 2, 15, 0])
            text(size = textSize, str(fireBasketWidth + profileSize));

            translate([outerWidth / 2 + 190, 15, 0])
            text(size = textSize, str(outerWidth - fireBasketWidth - (profileSize * 2)));

            translate([outerWidth - 15, 15, 0])
            text(size = textSize, str(profileSize));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = outerWidth + 40;

            translate([25, 15, 0])
            text(size = textSize, str(profileSize));

            translate([200, 15, 0])
            text(size = textSize, str(fireBasketWidth - profileSize));

            translate([fireBasketWidth + 25, 15, 0])
            text(size = textSize, str(profileSize));

            translate([fireBasketWidth + 65, 15, 0])
            text(size = textSize, str(profileSize));


            translate([outerWidth - 55, 15, 0])
            text(size = textSize, str(profileSize));

            translate([outerWidth / 2 + 200, 15, 0])
            text(size = textSize, str(outerWidth - fireBasketWidth - (profileSize * 4)));

            square([length, lineThickness]);
        }

    }
}

module measermentLinesHeight() {

        color([0/255, 0/255, 0/255])  {
            translate([0, 100, 0]) {

                translate([0, -lineGap, 0])
                square([lineThickness,lineGap * 4 + 20]);

                translate([profileSize, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([profileSize + spindleDiameter + 20, -lineGap -outerWidth + fireBasketWidth, 0])
                #square([lineThickness, lineGap + 20 + outerWidth - fireBasketWidth - 20 * 2]);

                translate([outerHeight - fireBasketGroundClearance - fireBasketHeight - profileSize * 2, 0, 0])
                square([lineThickness,lineGap + 20]);

                translate([outerHeight - fireBasketGroundClearance - profileSize, 0, 0])
                square([lineThickness,lineGap + 20]);


                translate([outerHeight - fireBasketGroundClearance, 0, 0])
                square([lineThickness,lineGap * 2 + 20]);

                translate([outerHeight, 0, 0])
                square([lineThickness,lineGap * 3 + 20]);


                // top line
                translate([-20, lineGap * 3, 0]) {
                    length = outerHeight + 40;

                    translate([outerHeight / 2, 15, 0])
                    text(size = textSize, str(outerHeight));

                    square([length, lineThickness]);
                }

                // middle line
                translate([-20, lineGap * 2, 0]) {
                    length = outerHeight + 40;

                    translate([outerHeight / 2, 15, 0])
                    text(size = textSize, str(outerHeight - fireBasketGroundClearance));

                    translate([outerHeight - 55, 15, 0])
                    text(size = textSize, str(fireBasketGroundClearance));

                    square([length, lineThickness]);
                }

                // bottom line
                translate([-20, lineGap, 0]) {
                    length = outerHeight + 40;

                    translate([25, 15, 0])
                    text(size = textSize, str(profileSize));

                    translate([250, 15, 0])
                    text(size = textSize, str(outerHeight - fireBasketGroundClearance - fireBasketHeight - (profileSize * 2)));

                    translate([outerHeight - fireBasketHeight - 30, 15, 0])
                    text(size = textSize, str(fireBasketHeight));


                    translate([outerHeight - fireBasketHeight + 135, 15, 0])
                    text(size = textSize, str(profileSize));

                    square([length, lineThickness]);
                }


                // bore line
                #translate([-20, -40, 0]) {
                    length = profileSize + 40 + spindleDiameter + 20;

                    translate([40, 15, 0])
                    text(size = textSize, str(profileSize + spindleDiameter + 20));

                    translate([profileSize * 2 + spindleDiameter + 40, -lineGap, 0])
                    rotate([0, 0, 90])
                    text(size = textSize, str("Bohrung Ø", spindleDiameter + 1));

                    square([length, lineThickness]);
                }

            }
        }
}

module measuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap * 2 + 20]);

        translate([profileSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([(outerDepth - profileSize) / 2 + profileSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([(outerDepth - profileSize) / 2, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([outerDepth - profileSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([outerDepth, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);


        translate([-20, lineGap * 2, 0]) {
            length = outerDepth + 40;

            translate([outerDepth / 2, 15, 0])
            text(size = textSize, str(outerDepth));

            square([length, lineThickness]);
        }

        translate([-20, lineGap, 0]) {
            length = outerDepth + 40;

            translate([25, 15, 0])
            text(size = textSize, str(profileSize));

            translate([200, 15, 0])
            text(size = textSize, str((outerDepth - profileSize * 3) / 2));

            translate([outerDepth / 2 + 5, 15, 0])
            text(size = textSize, str(profileSize));

            translate([outerDepth - 15, 15, 0])
            text(size = textSize, str(profileSize));

            translate([outerDepth / 2 + 200, 15, 0])
            text(size = textSize, str((outerDepth - profileSize * 3) / 2));

            square([length, lineThickness]);
        }
    }
}

module drawFrameFrontProjection() {

    // Vorne
    translate([outerWidth, - outerHeight, 0])
    projection() {
        rotate([90,0,180])
        frame();
    }
}

module drawFrameSideProjection() {
    translate([outerDepth, - outerHeight, 0])
    // // Seite
    rotate([0,0,90])
    projection() {
        translate([0, 0, 0])
        rotate([0,90,0])
        frame();
    }
}

module drawFrameTopProjection() {
    // // Draufsicht
    translate([outerWidth, 0, 0])
    projection() {
        rotate([0,0,180])
        frame();
    }
}