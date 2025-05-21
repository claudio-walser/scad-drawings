include <./niche.scad>


module walls(height, width, thickness) {

	color("grey") {
		cube(size=[width, thickness, height]);
	}

}

module compartment() {
	color("white") {
		cube(size=[cabinetThickness, cabinetDepth, seatHeight - nicheThickness + nicheHeight]);
		
		translate([compartmentWidth + cabinetThickness, 0, 0])
		cube(size=[cabinetThickness, cabinetDepth, seatHeight - nicheThickness + nicheHeight]);
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