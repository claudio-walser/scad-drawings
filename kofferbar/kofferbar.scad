module box(width, length, height, wallThickness, open = "top") {    
    // inner core in the center, equals to open == "none"
    innerHeight = open == "bottom" ? height+1 : (open == "top" ? height+1 : height);
    innerZ = open == "bottom" ? -wallThickness : (open == "top" ? wallThickness : 0);


    innerWidth = open == "left" ? width+1 : (open == "right" ? width+1 : width);
    innerX = open == "left" ? -wallThickness : (open == "right" ? wallThickness : 0);

    innerLength = open == "front" ? length+1 : (open == "back" ? length+1 : length);
    innerY = open == "front" ? -wallThickness : (open == "back" ? wallThickness : 0);


    translate([0, 0, height / 2 + wallThickness])
    difference() {
        cube(size = [length + 2 * wallThickness, width + 2 * wallThickness, height + 2 * wallThickness], center = true);
        translate([innerX, innerY, innerZ])
            cube(size = [innerLength, innerWidth, innerHeight], center = true);
    }
}

// box
box(width = 310, length = 390, height = 740, wallThickness = 15, open = "front" );

// deckel
translate([-421, -122.5, 0])
    box(width = 65, length = 390, height = 740, wallThickness = 15, open = "front" );

// weinfächer
translate([0, -15, 99])
    cube(size = [390, 310, 8], center= true);
translate([0, -15, 197])
    cube(size = [390, 310, 8], center= true);

translate([-49, -15, 115])
    cube(size = [8, 310,196], center= true);


translate([4, -15, 115])
    cube(size = [8, 310,196], center= true);

















