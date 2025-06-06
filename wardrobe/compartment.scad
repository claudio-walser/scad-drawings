module compartment() {
	compartmentHeight = seatHeight + nicheThickness + nicheHeight - cabinetThickness;

    // right side
    cube(size=[cabinetThickness, cabinetDepth, compartmentHeight]);

    // left side
    translate([compartmentWidth + cabinetThickness, 0, 0])
    cube(size=[cabinetThickness, cabinetDepth, compartmentHeight]);

    // bottom
    cube(size=[compartmentWidth + 2 * cabinetThickness, cabinetDepth, cabinetThickness]);

    // top
    translate([0, 0, compartmentHeight])
    cube(size=[compartmentWidth + 2 * cabinetThickness, cabinetDepth, cabinetThickness]);

    // middles
    for ($current = [1 : 1 : compartmentNumber]) {
        translate([0, 0, compartmentHeight - $current * (200 + cabinetThickness)])
        cube(size=[compartmentWidth + 2 * cabinetThickness, cabinetDepth, cabinetThickness]);
    }

    // reference cube
    //translate([cabinetThickness, 0, compartmentHeight - 200 - 200 - cabinetThickness- 200 - cabinetThickness- 200 - cabinetThickness- 200 - cabinetThickness])
    //#cube([200, cabinetDepth, 200]);

}