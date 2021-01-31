include <workbench.scad>;

scaleFactor = 10;

roomWidth = 3500;
roomLength = 4500;
roomHeight = 150;
roomWallThickness = 150;

module box(width, length, height, wallThickness, open = "top") {    
    // inner core in the center, equals to open == "none"
    innerHeight = open == "bottom" ? height+1 : (open == "top" ? height+1 : height);
    innerZ = open == "bottom" ? -wallThickness : (open == "top" ? wallThickness : 0);

    translate([0, 0, height / 2 + wallThickness])
    difference() {
        cube(size = [length + 2 * wallThickness, width + 2 * wallThickness, height + 2 * wallThickness], center = true);
        translate([0, 0, innerZ])
            cube(size = [length, width, innerHeight], center = true);
    }
}

scale([1 / scaleFactor, 1 / scaleFactor, 1 / scaleFactor]) {
    // room
    box(width = roomWidth, length = roomLength, height = roomHeight, wallThickness = roomWallThickness);

    // workbench in the middle
    //box(width = 1000, length = 1500, height = 1000, wallThickness = 18, open = "none" );
    
    workbench(
        width = 1200,
        length = 1800,
        height = 1000,
        deskThickness = 100,
        legThickness = 120,
        overstandDesk = 50
    );

    // Sharping station
    boxWidth = 450;
    boxLength = 600;
    boxWallThickness = 18;
    totallyRight = roomWidth / 2 - boxWidth / 2 - 2 * boxWallThickness;
    tottalyFront = roomLength / 2 - boxLength / 2 - 2 * boxWallThickness;
    translate([-tottalyFront, -totallyRight, 0]) box(width = boxWidth, length = boxLength, height = 1000, wallThickness = boxWallThickness, open = "none" );

    // Drill station
    boxWidth1 = 600;
    boxLength1 = 450;
    boxWallThickness1 = 18;
    totallyRight1 = roomWidth / 2 - boxWidth1 / 2 - 2 * boxWallThickness1;
    tottalyFront1 = roomLength / 2 - boxLength1 / 2 - 2 * boxWallThickness1;
    translate([-tottalyFront1, 0, 0]) box(width = boxWidth1, length = boxLength1, height = 1000, wallThickness = boxWallThickness1, open = "none" );

    // Mitre station
    boxWidth2 = 450;
    boxLength2 = 600;
    boxWallThickness2 = 18;
    totallyRight2 = roomWidth / 2 - boxWidth2 / 2 - 2 * boxWallThickness2;
    tottalyFront2 = roomLength / 2 - boxLength2 / 2 - 2 * boxWallThickness2;
    translate([-tottalyFront2, totallyRight2, 0]) box(width = boxWidth2, length = boxLength2, height = 1000, wallThickness = boxWallThickness2, open = "none" );

    // Saw station
    boxWidth3 = 650;
    boxLength3 = 680;
    boxWallThickness3 = 18;
    totallyRight3 = roomWidth / 2 - boxWidth3 / 2 - 2 * boxWallThickness3;
    tottalyFront3 = roomLength / 2 - boxLength3 / 2 - 2 * boxWallThickness3;
    translate([tottalyFront3, -totallyRight3, 0]) box(width = boxWidth3, length = boxLength3, height = 1000, wallThickness = boxWallThickness3, open = "none" );

    // Dust station
    boxWidth4 = 500;
    boxLength4 = 500;
    boxWallThickness4 = 18;
    totallyRight4 = roomWidth / 2 - boxWidth4 / 2 - 2 * boxWallThickness4;
    tottalyFront4 = roomLength / 2 - boxLength4 / 2 - 2 * boxWallThickness4;
    translate([tottalyFront4, totallyRight4, 0]) box(width = boxWidth4, length = boxLength4, height = 1000, wallThickness = boxWallThickness4, open = "none" );
    




    // Fat Boy
    translate([0, 900, 0]) cylinder(d=320,h=1830);
    // Lil Girl
    translate([0, -900, 0]) cylinder(d=180,h=1150);
}
