scaleFactor = 10;

roomWidth = 3500;
roomLength = 4500;
roomHeight = 2200;
roomWallThickness = 150;

module box(width, length, height, wallThickness, closed = false) {    
    translate([0, 0, height / 2 + wallThickness])
    difference() {
        cube(size = [length + 2 * wallThickness, width + 2 * wallThickness, height + 2 * wallThickness], center = true);
        translate([0, 0, wallThickness]) cube(size = [length, width, height + wallThickness], center = true);
    }
}

// translate([0, 40, 0]) {
//     box(width = 60, length = 85, height = 14, wallThickness = 1);
//     box(width = 58, length = 83, height = 17, wallThickness = 1);
// }
// translate([0, -40, 0]) {
//     box(width = 60, length = 85, height = 8, wallThickness = 1);
//     box(width = 58, length = 83, height = 5, wallThickness = 1);
// }

scale([1 / scaleFactor, 1 / scaleFactor, 1 / scaleFactor]) {
    box(width = roomWidth, length = roomLength, height = roomHeight, wallThickness = roomWallThickness);
    box(width = 1000, length = 1500, height = 1000, wallThickness = 18, closed = true );
    translate([0, 900, 0]) cylinder(d=320,h=1830);
}
