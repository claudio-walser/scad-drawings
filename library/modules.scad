module box(width, length, height, wallThickness, open = "top") {    
    // inner core in the center, equals to open == "none"
    innerHeight = open == "bottom" ? height+1 : (open == "top" ? height+1 : height);
    innerZ = open == "bottom" ? -wallThickness : (open == "top" ? wallThickness : 0);


    innerWidth = open == "left" ? width+1 : (open == "right" ? width+1 : width);
    innerX = open == "left" ? -wallThickness : (open == "right" ? wallThickness : 0);

    innerLength = open == "front" ? length-1 : (open == "back" ? length+1 : length);
    innerY = open == "front" ? -wallThickness : (open == "back" ? wallThickness : 0);


    translate([0, 0, height / 2 + wallThickness])
    difference() {
        cube(size = [length + 2 * wallThickness, width + 2 * wallThickness, height + 2 * wallThickness], center = true);
        translate([innerX, innerY, innerZ])
            cube(size = [innerLength, innerWidth, innerHeight], center = true);
    }
}

module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module boardMitreJoints(length, width, thickness) {
    // lower board with mitre joint
    cube(size = [length, width, thickness]);
    //difference() {
    //    cube(size = [length, width, thickness]);
    //    translate([0, 0, thickness]) rotate([0,90,0]) prism(width+100, thickness, thickness);
    //    translate([length, 0, thickness]) rotate([0,-180,0]) prism(width+100, thickness, thickness);
    //};
}
