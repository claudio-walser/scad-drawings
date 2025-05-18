include <./sitznische.scad>


module walls() {

	color("grey") {
		cube(size=[2500, 200, 2200]);
		
		translate([0, 0, 0])
		cube(size=[200, 2000, 2200]);
	}

}


walls();

translate([500, 200, 400])
sitznische();