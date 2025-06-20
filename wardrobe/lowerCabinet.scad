module lowerCabinet(width, height) {
    depth = cabinetDepth - cabinetThickness - 2; 
    innerHeight = height - cabinetThickness;

    // bottom
    cube(size=[width, depth, cabinetThickness]);

    // top
    translate([0, 0, height])
    cube(size=[width, depth, cabinetThickness]);
    
    // right
    translate([0, 0, cabinetThickness]) 
    cube(size=[cabinetThickness, depth, innerHeight]);

    // left
    translate([width - cabinetThickness, 0, cabinetThickness]) 
    cube(size=[cabinetThickness, depth, innerHeight]);

    // seat reference
    //#cube(size = [width, cabinetDepth, seatHeight]);
}