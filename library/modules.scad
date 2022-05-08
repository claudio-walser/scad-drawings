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
