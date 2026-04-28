$fn = 256;

tableTopWidth = 1000;
tableTopLength = 1790;

tableTopProfileWidth = 40;
tableTopProfileHeight = 20;
tableTopProfileGap = 30;
tableTopProfileThickness = 3;

tableFrameProfileWidth = 50;
tableFrameProfileHeight = 50;
tableFrameProfileThickness = 4;
tableFrameAirGap = 5;

tableSupportsWidth = 30;
tableSupportsThickness = 3;

tableFrameInnerProfileWidth = tableFrameProfileWidth - tableFrameProfileThickness * 2;
tableFrameInnerProfileHeight = tableFrameProfileHeight - tableFrameProfileThickness * 2;
tableFrameInnerProfileThickness = 3;

tableFrameExtensionLength = 950;

module tube(outerWidth = 40, outerHeight = 20, thickness = 3, length = 1500) {
    difference() {
        cube([length, outerWidth, outerHeight]);
        
        translate([-5, thickness, thickness])
        cube([length + 10, outerWidth - thickness * 2, outerHeight - thickness * 2]);
    }
}

module angle(outerWidth = 30, outerHeight = 30, thickness = 3, length = 1500) {
    difference() {
        cube([length, outerWidth, outerHeight]);
        
        translate([-5, thickness, thickness])
        cube([length + 10, outerWidth, outerHeight]);
    }
}

module tableTop() {
    // reference plate
    //cube ([1000, 1790, 10]);
    incrementWidth = tableTopProfileWidth + tableTopProfileGap;
    increments = (tableTopLength - tableTopProfileWidth) / incrementWidth;
    for (i=[0:increments]) {
       translate([0,i*incrementWidth,0])
         tube(
            outerWidth = tableTopProfileWidth,
            outerHeight = tableTopProfileHeight,
            thickness = tableTopProfileThickness,
            length = tableTopWidth
     
        );
    }


    // table fixations
    translate([tableSupportsWidth * 2 - tableFrameAirGap + 1, 0, 0])
    rotate([-90, 0, 90])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );

    translate([tableTopWidth - tableSupportsWidth * 2 + tableFrameAirGap - 1, 0, 0])
    rotate([180, 0, 90])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );
}

module topFrame() {
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2
    );

    translate([0, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth, 0])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2
    );

    // left
    translate([tableFrameProfileWidth, tableFrameProfileWidth, 0])
    rotate([0, 0, 90])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopWidth + tableFrameAirGap * 2
    );

    // right
    translate([tableFrameProfileWidth * 2 + tableTopLength + tableFrameAirGap * 2, tableFrameProfileWidth, 0])
    rotate([0, 0, 90])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopWidth + tableFrameAirGap * 2
    );

    // table supports
    translate([tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileWidth, tableFrameProfileHeight - tableTopProfileHeight])
    rotate([-90, 0, 0])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );

    translate([tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileWidth + tableFrameAirGap * 2 + tableTopWidth, tableFrameProfileHeight - tableTopProfileHeight])
    rotate([180, 0, 0])
    angle(
        outerWidth = tableSupportsWidth,
        outerHeight = tableSupportsWidth,
        thickness = tableSupportsThickness,
        length = tableTopLength
    );

    // extension left
    translate([-tableFrameProfileThickness, tableFrameProfileThickness, tableFrameProfileThickness])
    tube(
        outerWidth = tableFrameInnerProfileWidth,
        outerHeight = tableFrameInnerProfileHeight,
        thickness = tableFrameInnerProfileThickness,
        length = tableFrameExtensionLength
    );

    translate([-tableFrameProfileThickness, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth + tableFrameProfileThickness, tableFrameProfileThickness])
    tube(
        outerWidth = tableFrameInnerProfileWidth,
        outerHeight = tableFrameInnerProfileHeight,
        thickness = tableFrameInnerProfileThickness,
        length = tableFrameExtensionLength
    );

    translate([-tableFrameProfileThickness, tableFrameProfileWidth - tableFrameProfileWidth, 0])
    rotate([0, 0, 90])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopWidth + tableFrameProfileWidth * 2+ tableFrameAirGap * 2
    );


    // extension right
    translate([tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2 - tableFrameExtensionLength + tableFrameProfileThickness, tableFrameProfileThickness, tableFrameProfileThickness])
    tube(
        outerWidth = tableFrameInnerProfileWidth,
        outerHeight = tableFrameInnerProfileHeight,
        thickness = tableFrameInnerProfileThickness,
        length = tableFrameExtensionLength
    );

    translate([tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2 - tableFrameExtensionLength + tableFrameProfileThickness, tableTopWidth + tableFrameAirGap * 2 + tableFrameProfileWidth + tableFrameProfileThickness, tableFrameProfileThickness])
    tube(
        outerWidth = tableFrameInnerProfileWidth,
        outerHeight = tableFrameInnerProfileHeight,
        thickness = tableFrameInnerProfileThickness,
        length = tableFrameExtensionLength
    );

    translate([tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2 + tableFrameProfileThickness + tableFrameProfileWidth, tableFrameProfileWidth - tableFrameProfileWidth, 0])
    rotate([0, 0, 90])
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopWidth + tableFrameProfileWidth * 2+ tableFrameAirGap * 2
    );
} 

module legs() {
    tube(
        outerWidth = tableFrameProfileWidth,
        outerHeight = tableFrameProfileHeight,
        thickness = tableFrameProfileThickness,
        length = tableTopLength + tableFrameProfileWidth * 2 + tableFrameAirGap * 2
    );
}

color("grey")
topFrame();

translate([tableTopLength + tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileWidth + tableFrameAirGap, tableFrameProfileHeight - tableTopProfileHeight])
rotate([0, 0, 90])
tableTop();