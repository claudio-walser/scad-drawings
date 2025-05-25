module shoeRack() {
	rackWidth = nicheWidth + 2 * nicheThickness;

    // bottom
    cube(size=[rackWidth, cabinetDepth, cabinetThickness]);

    // top
    translate([0, 0, shoeRackHeight])
    cube(size=[rackWidth, cabinetDepth, cabinetThickness]);
    
        
    // translate([0, 0, cabinetThickness]) {
    // 	// right side
    // 	cube(size=[cabinetThickness, cabinetDepth, compartmentHeight]);

    // 	// left side
    // 	translate([compartmentWidth + cabinetThickness, 0, 0])
    // 	cube(size=[cabinetThickness, cabinetDepth, compartmentHeight]);

    // 	// bottom
    // 	cube(size=[compartmentWidth + 2 * cabinetThickness, cabinetDepth, cabinetThickness]);

    // 	// top
    // 	translate([0, 0, compartmentHeight])
    // 	cube(size=[compartmentWidth + 2 * cabinetThickness, cabinetDepth, cabinetThickness]);

    // 	// middles
    // 	number = 5;

    // 	for ($current = [1 : 1 : number]) {
    // 		translate([0, 0, compartmentHeight - $current * (200 + cabinetThickness)])
    // 		cube(size=[compartmentWidth + 2 * cabinetThickness, cabinetDepth, cabinetThickness]);
    // 	}

    // 	// reference cube
    // 	//translate([cabinetThickness, 0, compartmentHeight - 200 - 200 - cabinetThickness- 200 - cabinetThickness- 200 - cabinetThickness- 200 - cabinetThickness])
    // 	//#cube([200, cabinetDepth, 200]);
    // }
}