include <../../library/profiles.scad>
include <./config.scad>

module grateFrame+() {

    grateGap = 4;
    grateSize = 30;
    profileThickness = 3;
    grateLength = outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 2);
    grateWidth = outerDepth - profileSize;

    module partsList() {

    }
    partsList();

    // hinten
    translate([(profileSize * 2) + grateGap, profileSize + grateGap + profileThickness, 0]) lShapeProfile(grateLength, grateSize, profileThickness);

    // rechts
    translate([(profileSize * 2) + grateGap, profileSize + grateGap + profileThickness, 0])
    rotate([90, 0, 90])
    lShapeProfile(grateWidth, grateSize, profileThickness);

    // links
    translate([(profileSize * 2) + grateGap, profileSize + grateGap + profileThickness, 0])
    rotate([0, 0, 90])
    translate([0, -(grateLength), 0])
    lShapeProfile(grateWidth, grateSize, profileThickness);

    // vorne
    translate([grateLength + (profileSize * 2) + grateGap, profileSize + grateGap + profileThickness + grateWidth, 0])
    rotate([0, 0, 180])
    lShapeProfile(grateLength, grateSize, profileThickness);

}
