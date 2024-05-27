include <./config.scad>
include <../../library/profiles.scad>


basketClearance = 5;
basketFlatIron = 3;
totalClearance = basketClearance + basketFlatIron;
basketFrameGap = 60;
basketProfileSize = profileSize / 2;
basketWidth = fireBasketWidth - (profileSize) - (totalClearance * 2);
basketHeight = fireBasketHeight + (profileSize);

// calculations
idealGap = basketFrameGap + basketProfileSize;
numRips = floor(outerDepth / idealGap);
ripGap = (outerDepth - basketProfileSize) / numRips;

filletWidth = basketWidth - (basketProfileSize * 2) - (totalClearance * 2);
numFillet = floor((filletWidth) / idealGap);
filletGap = (filletWidth - basketProfileSize ) / numFillet;



module fireBasketPartsList() {
    // FireBasket
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    echo(str("60,Feuerkorb Seitlich - Vierkantrohr,", numRips * 2, ",", basketHeight - basketFlatIron, ",", basketProfileSize, ",", basketProfileSize));
    echo(str("61,Feuerkorb Unten - Vierkantrohr ,", numRips, ",", basketWidth, ",", basketProfileSize, ",", basketProfileSize));
    echo(str("62,Fillets Vorne und Hinten - Vierkantrohr ,", (numFillet+1) * 2, ",", basketHeight - basketFlatIron - basketProfileSize, ",", basketProfileSize, ",", basketProfileSize));
    echo(str("63,Flachstahl lang ,", 4, ",", outerDepth, ",", basketProfileSize, ",", basketFlatIron));
    echo(str("64,Flachstahl kurz ,", 2, ",", basketWidth + (basketFlatIron * 2), ",", basketProfileSize, ",", basketFlatIron));
    echo(str("64,Winkelprofil - Fixierung ,", 2, ",", basketWidth, ",", 30, ",", 30));
}


module fireBasket() {

    module basketFrame() {

        cube(size = [basketWidth, basketProfileSize, basketProfileSize]);
        cube(size = [basketProfileSize, basketProfileSize, basketHeight - basketFlatIron]);

        translate([basketWidth - basketProfileSize, 0, 0])
        cube(size = [basketProfileSize, basketProfileSize, basketHeight - basketFlatIron]);
    }

    module fillet() {
        translate([0, 0, basketProfileSize])
        cube(size = [basketProfileSize, basketProfileSize, basketHeight - basketFlatIron - basketProfileSize]);
    }

    translate([totalClearance, 0, basketFlatIron]){
        // all frames
        for ( i = [0 : numRips] ){
            stepMove = i * ripGap;
            translate([0, stepMove, 0])
            basketFrame();
        }

        if (!fireBasketFrontOpen) {
            // back fillets
            for ( i = [1 : numFillet] ){
                stepMove = (i * filletGap) + basketProfileSize - (basketProfileSize * 1.5);
                translate([stepMove, 0, 0])
                fillet();
            }

            translate([0, outerDepth - basketProfileSize, 0])
            for ( i = [1 : numFillet] ){
                stepMove = (i * filletGap) + basketProfileSize - (basketProfileSize * 1.5);
                translate([stepMove, 0, 0])
                fillet();
            }
        }

        // flat iron below
        translate([(basketWidth / 4), 0, - basketFlatIron])
        cube(size = [basketProfileSize, outerDepth, basketFlatIron]);
        translate([(basketWidth / 4 * 3) - basketProfileSize, 0, - basketFlatIron])
        cube(size = [basketProfileSize, outerDepth, basketFlatIron]);


        // flat iron sides
        translate([- basketFlatIron, 0, fireBasketHeight - basketFlatIron - (basketProfileSize * 2)])
        cube(size = [basketFlatIron, outerDepth, basketProfileSize]);
        translate([basketWidth, 0, fireBasketHeight - basketFlatIron - (basketProfileSize * 2)])
        cube(size = [basketFlatIron, outerDepth, basketProfileSize]);

        // fixation
        translate([basketWidth / 4, profileSize + 2, - basketFlatIron])
        rotate([-90, 0, 0])
        lShapeProfile(basketWidth / 2, 30, 3);

        translate([basketWidth / 4, outerDepth - profileSize - 2, - basketFlatIron])
        rotate([180, 0, 0])
        lShapeProfile(basketWidth / 2, 30, 3);

        if (!fireBasketFrontOpen) {
            // flat iron front and back
            translate([-basketFlatIron, -basketFlatIron, fireBasketHeight - basketFlatIron - (basketProfileSize * 2)])
            cube(size = [basketWidth + (basketFlatIron * 2), basketFlatIron, basketProfileSize]);
            // flat iron front and back
            translate([-basketFlatIron, outerDepth, fireBasketHeight - basketFlatIron - (basketProfileSize * 2)])
            cube(size = [basketWidth + (basketFlatIron * 2), basketFlatIron, basketProfileSize]);
        }

    }
}

module fireBasketMeasuermentLinesLength() {

    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {

        square([lineThickness,lineGap + 20]);

        translate([basketFlatIron, 0, 0])
        square([lineThickness,lineGap * 3 + 20]);

        translate([basketProfileSize, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        translate([basketWidth / 4, 0, 0])
        square([lineThickness,lineGap + 20]);


        translate([basketWidth / 4 + basketProfileSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([basketWidth / 4 + basketWidth / 2 - basketProfileSize, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([basketWidth / 4 + basketWidth / 2, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([basketWidth - basketProfileSize + basketFlatIron, 0, 0])
        square([lineThickness,lineGap * 2 + 20]);

        translate([basketWidth + basketFlatIron, 0, 0])
        square([lineThickness,lineGap * 3 + 20]);

        translate([basketWidth + basketFlatIron * 2, 0, 0])
        square([lineThickness,lineGap + 20]);

        translate([-20, lineGap * 3, 0]) {
            length = fireBasketWidth - profileSize + basketFlatIron * 2 + 20;

            translate([basketWidth / 2, 15, 0])
            text(size = textSize, str(basketWidth));

            square([length, lineThickness]);

        }

        translate([-20, lineGap * 2, 0]) {
            length = fireBasketWidth - profileSize + basketFlatIron * 2 + 20;

            translate([basketProfileSize + 5, 15, 0])
            text(size = textSize, str(basketProfileSize));


            translate([basketWidth / 2, 15, 0])
            text(size = textSize, str(basketWidth - basketProfileSize * 2));


            translate([basketWidth - 10, 15, 0])
            text(size = textSize, str(basketProfileSize));

            square([length, lineThickness]);

        }

        translate([-20, lineGap, 0]) {
            length = fireBasketWidth - profileSize + basketFlatIron * 2 + 20;

            translate([0, 15, 0])
            text(size = textSize, str(basketFlatIron));



            translate([basketWidth / 4 - 25, 15, 0])
            text(size = textSize, str(basketWidth / 4 - basketProfileSize));

            translate([basketWidth / 4 + basketProfileSize - 5, 15, 0])
            text(size = textSize, str(basketProfileSize));

            translate([basketWidth / 2, 15, 0])
            text(size = textSize, str(basketWidth / 2 - basketProfileSize * 2));

            translate([fireBasketWidth - fireBasketWidth / 4 - basketProfileSize * 2 - 5, 15, 0])
            text(size = textSize, str(basketProfileSize));

            translate([fireBasketWidth - fireBasketWidth / 4, 15, 0])
            text(size = textSize, str(basketWidth / 4 - basketProfileSize));

            translate([basketWidth + 30, 15, 0])
            text(size = textSize, str(basketFlatIron));

            square([length, lineThickness]);
        }

    }
}


module fireBasketMeasermentLinesHeight() {

        color([0/255, 0/255, 0/255])  {
            translate([0, 0, 0]) {

                translate([0, 0, 0])
                square([lineThickness,lineGap * 2+ 20]);

                translate([basketHeight - basketFlatIron, 0, 0])
                square([lineThickness, lineGap * 2 + 20]);

                translate([basketHeight, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([basketHeight + 30, 0, 0])
                square([lineThickness, lineGap + 20]);

                translate([basketHeight - basketProfileSize, 0, 0])
                square([lineThickness, lineGap + 20]);


                //fireBasketHeight - basketFlatIron - (basketProfileSize * 2)
                translate([basketHeight - (fireBasketHeight - (basketProfileSize * 2)), 0, 0])
                square([lineThickness, lineGap + 20]);

                //fireBasketHeight - basketFlatIron - (basketProfileSize * 2)
                translate([basketHeight - (fireBasketHeight - (basketProfileSize)), 0, 0])
                square([lineThickness, lineGap + 20]);


                // top line
                translate([-20, lineGap * 2, 0]) {
                    length = basketHeight + basketFlatIron + 30 + 40;

                    translate([basketHeight / 2, 15, 0])
                    text(size = textSize, str(basketHeight - basketFlatIron));

                    square([length, lineThickness]);
                }

                // bottom line
                translate([-20, lineGap, 0]) {
                    length = basketHeight + basketFlatIron + 30 + 40;

                    translate([35, 15, 0])
                    text(size = textSize, str(basketHeight - (fireBasketHeight - basketProfileSize)));

                    translate([35 + profileSize, 15, 0])
                    text(size = textSize, str(basketProfileSize));

                    translate([basketHeight / 2, 15, 0])
                    text(size = textSize, str(basketHeight - basketProfileSize * 2 - (basketHeight +  basketFlatIron- (fireBasketHeight - basketProfileSize))));

                    translate([basketHeight - basketProfileSize/2 - 10, 15, 0])
                    text(size = textSize, str(basketProfileSize));

                    translate([basketHeight + basketProfileSize, 15, 0])
                    text(size = textSize, str(basketFlatIron));

                    translate([basketHeight + basketProfileSize * 2, 15, 0])
                    text(size = textSize, str(30));


                    square([length, lineThickness]);
                }
            }
        }
}



module fireBasketMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, 100, 0]) {
        // ribs not rips 🙈
        for ( i = [0 : numRips] ){
            if (i == 0) {
                // first line longer
                stepMove = i * ripGap;
                translate([stepMove, 0, 0])
                square([lineThickness, lineGap * 2 + 20]);

                translate([stepMove + basketProfileSize, 0, 0])
                square([lineThickness, lineGap + 20]);
            } else if(i == numRips) {
                // last line longer
                stepMove = i * ripGap;
                translate([stepMove, 0, 0])
                square([lineThickness, lineGap+ 20]);

                translate([stepMove + basketProfileSize, 0, 0])
                square([lineThickness, lineGap * 2 + 20]);
            } else {
                stepMove = i * ripGap;
                translate([stepMove, 0, 0])
                square([lineThickness, lineGap+ 20]);

                translate([stepMove + basketProfileSize, 0, 0])
                square([lineThickness, lineGap + 20]);
            }
        }

        // below measurement lines
        translate([0, -basketHeight - lineGap * 3 - 20, 0])
        square([lineThickness, lineGap + 20]);


        translate([profileSize + basketFlatIron, -basketHeight - lineGap * 3 - 20, 0])
        square([lineThickness, lineGap + 20]);

        translate([profileSize + basketFlatIron + 30, -basketHeight - lineGap * 3 - 20, 0])
        square([lineThickness, lineGap + 20]);



        translate([outerDepth - profileSize - basketFlatIron - 30, -basketHeight - lineGap * 3 - 20, 0])
        square([lineThickness, lineGap + 20]);

        translate([outerDepth - profileSize - basketFlatIron, -basketHeight - lineGap * 3 - 20, 0])
        square([lineThickness, lineGap + 20]);




        translate([outerDepth, -basketHeight - lineGap * 3 - 20, 0])
        square([lineThickness, lineGap + 20]);



        // top line
        translate([-20, lineGap * 2, 0]) {
            length = outerDepth + 40;

            translate([outerDepth / 2, 15, 0])
            text(size = textSize, str(outerDepth));

            square([length, lineThickness]);
        }

        // bottom line
        translate([-20, lineGap, 0]) {
            length = outerDepth + 40;

            for ( i = [0 : numRips] ){
                stepMove = i * ripGap;
                translate([stepMove + 15, 15, 0])
                text(size = textSize, str(20));

                if (i < numRips) {
                    translate([stepMove + 55, 15, 0])
                    text(size = textSize, str(ripGap-basketProfileSize));
                }

            }

            square([length, lineThickness]);
        }


        // below line
        translate([-20, -basketHeight - lineGap * 3, 0]) {
            length = outerDepth + 40;

            translate([(profileSize + basketFlatIron) / 2 + 5, 15, 0])
            text(size = textSize, str(profileSize + basketFlatIron));

            translate([(profileSize * 2) - 15, 15, 0])
            text(size = textSize, str(30));

            translate([(outerDepth - profileSize * 2) + 25, 15, 0])
            text(size = textSize, str(30));

            translate([outerDepth - 15, 15, 0])
            text(size = textSize, str(profileSize + basketFlatIron));

            square([length, lineThickness]);
        }


    }
}


module drawFireBasketFrontProjection() {

    // Vorne
    translate([fireBasketWidth - profileSize - totalClearance + basketFlatIron, -fireBasketHeight - 30 - totalClearance - basketFlatIron + 1, 0])
    projection() {
        rotate([90,0,180])
        fireBasket();
    }

}

module drawFireBasketSideProjection() {
    translate([outerDepth, - basketHeight, 0])
    // // Seite
    rotate([0, 0, 90])
    projection() {
        translate([0, 0, 0])
        rotate([0, 90, 0])
        fireBasket();
    }
}

module drawFireBasketTopProjection() {


    // // Draufsicht
    translate([fireBasketWidth - profileSize - basketFlatIron - 2, 0, 0])
    projection() {
        rotate([0,0,180])
        fireBasket();
    }

}



module fireProtection() {

    difference() {
        cube([outerDepth, outerHeight - fireBasketHeight, 1]);

        translate([0, outerHeight - fireBasketHeight - 70.7, -5])
        rotate([0, 0, 45])
        cube([100, 100, 10]);


        translate([outerDepth, outerHeight - fireBasketHeight - 70.7, -5])
        rotate([0, 0, 45])
        cube([100, 100, 10]);
        //a = √(d² / 2)
    }

}


module fireProtectionPartsList() {
    // FireProtection
    echo(str("Nr,Beschreibung,Stück,Länge,Breite,Höhe"));

    echo(str("1,Feuerschutz,1,", outerDepth, ",", outerHeight - fireBasketHeight, ",1"));
}

module fireProtectionMeasuermentLinesLength() {
    color([0/255, 0/255, 0/255]) translate([0, 60, 0]) {
        // corner length //a = √(d² / 2)

        cornerLength = sqrt(pow(100, 2) / 2);
        roundedCornerLegnth = round(cornerLength);

        translate([0, 0, 0])
        square([lineThickness, lineGap * 2 + 20]);


        translate([cornerLength, 0, 0])
        square([lineThickness, lineGap + 20]);

        translate([outerDepth - cornerLength, 0, 0])
        square([lineThickness, lineGap + 20]);


        translate([outerDepth, 0, 0])
        square([lineThickness, lineGap * 2 + 20]);





        // top line
        translate([-20, lineGap * 2, 0]) {
            length = outerDepth + 40;

            translate([outerDepth / 2, 15, 0])
            text(size = textSize, str(outerDepth));

            square([length, lineThickness]);
        }


        // bottom line
        translate([-20, lineGap, 0]) {
            length = outerDepth + 40;

            translate([outerDepth / 2, 15, 0])
            text(size = textSize, str(outerDepth - roundedCornerLegnth * 2));


            translate([45, 15, 0])
            text(size = textSize, str(roundedCornerLegnth));

            translate([outerDepth - 35, 15, 0])
            text(size = textSize, str(roundedCornerLegnth));

            square([length, lineThickness]);
        }

    }
}


module fireProtectionMeasuermentLinesWidth() {
    color([0/255, 0/255, 0/255]) translate([0, 60, 0]) {
        // corner length //a = √(d² / 2)

        cornerLength = sqrt(pow(100, 2) / 2);
        roundedCornerLegnth = round(cornerLength);

        translate([0, 0, 0])
        square([lineThickness, lineGap * 2 + 20]);


        translate([cornerLength, 0, 0])
        square([lineThickness, lineGap + 20]);


        translate([outerHeight - fireBasketHeight, 0, 0])
        square([lineThickness, lineGap * 2 + 20]);


        // top line
        translate([-20, lineGap * 2, 0]) {
            length = outerHeight - fireBasketHeight + 40;

            translate([length / 2, 15, 0])
            text(size = textSize, str(outerHeight - fireBasketHeight));

            square([length, lineThickness]);
        }


        // bottom line
        translate([-20, lineGap, 0]) {
            length = outerHeight - fireBasketHeight + 40;

            translate([length / 2, 15, 0])
            text(size = textSize, str(outerHeight - fireBasketHeight - roundedCornerLegnth));


            translate([45, 15, 0])
            text(size = textSize, str(roundedCornerLegnth));


            square([length, lineThickness]);
        }

    }
}

module drawFireProtectionTopProjection() {


    // // Draufsicht
    translate([0, -outerHeight + fireBasketHeight, 0])
    projection() {
        fireProtection();
    }
}