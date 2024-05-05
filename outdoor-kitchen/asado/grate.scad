include <../../library/profiles.scad>
include <./config.scad>

module grateFrame() {


    grateLength = outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4);
    grateWidth = outerDepth - profileSize - (2 * grateProfileThickness);

    module partsList() {

    }
    partsList();


    translate([grateGap, 0, 0]) {
        // x (profileSize * 2) + grateGap
        // y profileSize + grateGap + grateProfileThickness
        // hinten
        lShapeProfile(grateLength, grateSize, grateProfileThickness);

        // rechts
        rotate([90, 0, 90])
        lShapeProfile(grateWidth, grateSize, grateProfileThickness);

        // links
        rotate([0, 0, 90])
        translate([0, -(grateLength), 0])
        lShapeProfile(grateWidth, grateSize, grateProfileThickness);

        // vorne
        translate([
            grateLength,
            grateWidth,
            0
        ])

        rotate([0, 0, 180])
        lShapeProfile(grateLength, grateSize, grateProfileThickness);

        translate([0, (grateWidth / 2) - ((profileSize + 10) - 1), 0])
        rotate([0, 270, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, 4);

        translate([grateLength, (grateWidth / 2) - ((profileSize + 10) - 1), fireBasketGroundClearance - 20])
        rotate([0, 90, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, 4);
    }
}
