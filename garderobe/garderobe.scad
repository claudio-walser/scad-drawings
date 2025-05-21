include <./niche.scad>


module walls(height, width, thickness) {

	color("grey") {
		cube(size=[width, thickness, height]);
	}

}

module compartment() {
	compartmentHeight = seatHeight - nicheThickness + nicheHeight - 2 * cabinetThickness;

	color("white") {
		translate([0, 0, cabinetThickness]) {
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
			number = 5;

			for ($current = [1 : 1 : number]) {
				translate([0, 0, compartmentHeight - $current * (200 + cabinetThickness)])
				cube(size=[compartmentWidth + 2 * cabinetThickness, cabinetDepth, cabinetThickness]);
			}

			// reference cube
			//translate([cabinetThickness, 0, compartmentHeight - 200 - 200 - cabinetThickness- 200 - cabinetThickness- 200 - cabinetThickness- 200 - cabinetThickness])
			//#cube([200, cabinetDepth, 200]);
		}
	}
}


wallHeight = 2350;
wallWidth = 2322;
wallThickness = 125;

nicheHeight = 1400;
nicheWidth = 1400;
nicheThickness = 25;
nicheDepth = 400;

seatHeight = 470;

compartmentWidth = 200;
cabinetThickness = 19;
cabinetDepth = 350;


walls(height = wallHeight, width = wallWidth, thickness = wallThickness);


translate([compartmentWidth + 2 * cabinetThickness, wallThickness, seatHeight - nicheThickness])
niche(width = nicheWidth, height = nicheHeight, thickness = nicheThickness, depth = nicheDepth);

translate([0, wallThickness, 0])
compartment();