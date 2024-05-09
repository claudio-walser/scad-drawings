include <./config.scad>

module fireBasket() {

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


    module partsList() {
        // Spindelplatte
        echo(str("60;Feuerkorb Seitlich - Vierkantrohr;", numRips * 2, ";", basketHeight - basketFlatIron, ";", basketProfileSize, ";", basketProfileSize));
        echo(str("61;Feuerkorb Unten - Vierkantrohr ;", numRips, ";", basketWidth, ";", basketProfileSize, ";", basketProfileSize));
        echo(str("62;Fillets Vorne und Hinten - Vierkantrohr ;", (numFillet+1) * 2, ";", basketHeight - basketFlatIron - basketProfileSize, ";", basketProfileSize, ";", basketProfileSize));
        echo(str("63;Flachstahl lang ;", 4, ";", outerDepth, ";", basketProfileSize, ";", basketFlatIron));
        echo(str("64;Flachstahl kurz ;", 2, ";", basketWidth + (basketFlatIron * 2), ";", basketProfileSize, ";", basketFlatIron));
    }

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

    partsList();

}