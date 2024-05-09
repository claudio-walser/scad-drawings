include <../../library/profiles.scad>
include <./config.scad>

module grateTemplate(grateLength = 600, grateWidth = 400) {
    module partsList() {

    }

    partsList();

    // hinten
    cube([grateLength, profileSize + 5, profileSize+ 5]);
    
    // vorne
    translate([0, grateWidth - profileSize, 0])
    cube([grateLength, profileSize, profileSize]);
    

    // rippen
    amount = round(grateLength / 35);
    startPos = 18;
    echo(str("anzahl ", amount))
    for ( i = [0 : amount - 1] ) {
        translate([(i * 35) + startPos, 0, 45])
        rotate([45, 0.5, 90])
        lShapeProfile(grateWidth + 20, 20, 2);
    }
}

module grate() {
    grateLength = outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4) - ((4 * grateProfileThickness));
    grateWidth = outerDepth - profileSize - (6 * grateProfileThickness);

    grateTemplate(grateLength, grateWidth);
}

module halfGrate() {
    halfGrateLength = (outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4) - ((5 * grateProfileThickness))) / 2;
    grateWidth = outerDepth - profileSize - (6 * grateProfileThickness);

    grateTemplate(halfGrateLength, grateWidth);
}

