include <../../library/profiles.scad>
include <./config.scad>


grateLength = floor(outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4) - ((4 * grateProfileThickness)));
grateWidth = outerDepth - profileSize - (6 * grateProfileThickness);
halfGrateLength = floor((grateLength - grateProfileThickness) / 2);


module grateTemplate(grateLength = 400, grateWidth = 400, frontProjection = false) {
    // hinten
    if (frontProjection) {
        cube([grateLength, profileSize, profileSize]);
    } else {
        cube([grateLength, profileSize + 5, profileSize + 5]);
    }
    // vorne
    translate([0, grateWidth - profileSize - 8, 0])
    cube([grateLength, profileSize - 5 , profileSize - 5]);
    
    if (frontProjection) {
        // rippen
        amount = round(grateLength / 35);
        startPos = 16;
        echo(str("anzahl ", amount))
        for ( i = [0 : amount - 1] ) {
            translate([(i * 35) + startPos, 0, profileSize])
            rotate([45, 0, 90])
            lShapeProfile(grateWidth + 30, 20, 2);
        }
    } else {
        // rippen
        amount = round(grateLength / 35);
        startPos = 16;
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
    echo(str("1,Vierkant Vorne", ",", "1", ",", halfGrateLength, ",", profileSize, ",", profileSize));
    echo(str("2,Vierkant Vorne", ",", "1", ",", halfGrateLength, ",", profileSize + 5, ",", profileSize + 5));
    // Rost
    echo(str("3,Winkel für Rost", ",", amount, ",", grateWidth + 30, ",20,20"));

}


module drawHalfGrateFrontProjection() {

    // Vorne
    translate([outerWidth, - outerHeight, 0])
    projection() {
        rotate([90,0,180])
        halfGrate(frontProjection = true);
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