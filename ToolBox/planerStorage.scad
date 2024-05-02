$fn=50; // Increase detail level of curves

// Board dimensions
length = 200; // Length of the board in mm
height = 15; // Height (thickness) of the board in mm
width = 100; // Width of the board in mm

// Dovetail parameters
dovetail_count = 3; // Number of dovetails
dovetail_angle = 75; // Angle of the dovetail in degrees
dovetail_depth = height / 2; // Depth of the dovetails, half the board's thickness for simplicity

// Basic dovetail shape (for demonstration, assuming symmetry and simple proportions)
module dovetail() {
    mirror([1, 0, 0]) {
        linear_extrude(height = dovetail_depth) {
            polygon(points=[[0,0], [1,1/tan(dovetail_angle/2)], [1,width/(dovetail_count*2)-1/tan(dovetail_angle/2)], [0,width/(dovetail_count*2)]]);
        }
    }
}

// Board with male dovetails
module board_male() {
    difference() {
        // The board itself
        cube([length, width, height]);
        // Remove material to form the male part of the dovetails
        for (i = [1:2:dovetail_count*2-1]) {
            translate([0, i * width / (dovetail_count * 2), 0])
            dovetail();
        }
    }
}

// Board with female dovetails (slots)
module board_female() {
    union() {
        // The board itself, with cutouts for the dovetails
        cube([length, width, height]);
        // Add material where the dovetails fit
        for (i = [0:2:dovetail_count*2-2]) {
            translate([0, i * width / (dovetail_count * 2), height - dovetail_depth])
            dovetail();
        }
    }
}

// Position and render both boards for demonstration
translate([0, 0, -height])
board_male();
translate([length, width/2, -width/2 - height/2])
rotate([0, -90, 0])
board_female();