include <../../library/profiles.scad>
include <./config.scad>

module grate() {

    grateLength = outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4) - ((4 * grateProfileThickness));
    grateWidth = outerDepth - profileSize - (6 * grateProfileThickness);

    module partsList() {

    }

    partsList();

    // hinten
    cube([grateLength, profileSize + 5, profileSize+ 5]);
    
    // vorne
    translate([0, grateWidth - profileSize, 0])
    cube([grateLength, profileSize, profileSize]);
    

    // rippen
    amount = floor(grateLength / 35);
    startPos = 18;
    echo(str("anzahl ", amount))
    for ( i = [0 : amount - 1] ) {
        translate([(i * 35) + startPos, 0, 45])
        rotate([45, 0.5, 90])
        lShapeProfile(grateWidth + 20, 20, 2);
    }
}



