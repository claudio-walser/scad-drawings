module shoeRack(width, height) {
    innerHeight = height - cabinetThickness;

    // bottom
    cube(size=[width, cabinetDepth, cabinetThickness]);

    // top
    translate([0, 0, height])
    cube(size=[width, cabinetDepth, cabinetThickness]);
    
    // right
    translate([0, 0, cabinetThickness]) 
    cube(size=[cabinetThickness, cabinetDepth, innerHeight]);

    // middle
    translate([(width - cabinetThickness) / 2, 0, cabinetThickness]) 
    cube(size=[cabinetThickness, cabinetDepth, innerHeight]);

    // left
    translate([width - cabinetThickness, 0, cabinetThickness]) 
    cube(size=[cabinetThickness, cabinetDepth, innerHeight]);

    // seat reference
    //#cube(size = [width, cabinetDepth, seatHeight]);
}