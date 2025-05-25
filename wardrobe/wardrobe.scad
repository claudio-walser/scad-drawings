include <./niche.scad>
include <./compartment.scad>
include <./shoerack.scad>


module walls(height, width, thickness) {

	color("grey") {
		cube(size=[width, thickness, height]);
	}

}

wallHeight = 2350;
wallWidth = 2322;
wallThickness = 125;

// inner measure
nicheHeight = 1400;
// inner measure
nicheWidth = 1400;
nicheThickness = 25;
nicheDepth = 400;

seatHeight = 470;

compartmentWidth = 200;
cabinetThickness = 19;
cabinetDepth = 350;

shoeRackHeight = 200;



walls(height = wallHeight, width = wallWidth, thickness = wallThickness);


translate([compartmentWidth + 2 * cabinetThickness, wallThickness, seatHeight - nicheThickness])
color("#5b3a29") niche(width = nicheWidth, height = nicheHeight, thickness = nicheThickness, depth = nicheDepth);

translate([0, wallThickness, 0])
color("white") compartment();


translate([compartmentWidth + 2 * cabinetThickness, wallThickness, 0])
shoeRack();