include <../../library/profiles.scad>
include <./config.scad>
include <./grate.scad>


grateLength = outerWidth - fireBasketWidth - (profileSize * 4) - (grateGap * 4);
grateWidth = outerDepth - profileSize - (2 * grateProfileThickness);

trayThickness = 3;
trayWidth = 60;

module grateFrame() {




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

        // Führungen seitlich
        translate([0, (grateWidth / 2) - ((profileSize + 10) - 1), 0])
        rotate([0, 270, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, 4);

        translate([grateLength, (grateWidth / 2) - ((profileSize + 10) - 1), fireBasketGroundClearance - 20])
        rotate([0, 90, 0])
        uShapeProfile(fireBasketGroundClearance - 20, profileSize + 10, 4);

    }
}

module collectingTrayMount() {
        translate([0, -trayThickness, 0])
        cube([trayWidth / 3, trayWidth + trayThickness * 2, trayThickness]);

        translate([0, -trayThickness, 0])
        cube([trayWidth / 3,  trayThickness,  trayWidth + trayThickness * 2]);

        translate([0, trayWidth, 0])
        cube([trayWidth / 3,  trayThickness,  trayWidth  / 3]);

        translate([0, -trayThickness * 3, trayWidth + trayThickness])
        cube([trayWidth / 3,  trayThickness * 3,  trayThickness]);

        translate([0, -trayThickness * 3, trayWidth - trayWidth / 3 + trayThickness * 2])
        cube([trayWidth / 3,  trayThickness,  trayWidth / 3]);
}

module collectingTray() {


    uShapeProfile(grateLength, trayWidth, trayThickness);

    cube([trayThickness, trayWidth, trayWidth]);

    translate([grateLength - trayThickness, 0, 0])
    cube([trayThickness, trayWidth, trayWidth]);



    translate([0, 0, -trayThickness]) {

        translate([50, 0, 0])
        collectingTrayMount();

        translate([grateLength - (50 + trayWidth / 3), 0, 0])
        collectingTrayMount();

        translate([grateLength / 2 - ((trayWidth / 3) / 2), 0, 0])
        collectingTrayMount();

    }

}
