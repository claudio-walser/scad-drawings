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
                    text(size = textSize, str(basketHeight));

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
                    text(size = textSize, str(basketHeight - basketProfileSize * 2 - (basketHeight - (fireBasketHeight - basketProfileSize))));

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
    rotate([0,0,90])
    projection() {
        translate([0, 0, 0])
        rotate([0,90,0])
        fireBasket();
    }
}