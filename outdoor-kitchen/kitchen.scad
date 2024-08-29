include <../library/modules.scad>
include <./asado/assembly.scad>
include <./big-green-egg/large.scad>
include <./sink/sink.scad>
include <./cabinets/cabinets.scad>
include <./roaring-dragon/burner.scad>
include <../garden/pergola.scad>
include <./models/gas-bottle.scad>
// Fläche
cube(size = [floorLength, floorWidth, 10]);


module unifiedSink() {
	// sink tube
	translate([425, 3230, 0])
	color("lightgreen") cylinder(h=700, r=80);

	// sink
	translate([300, 3230-(450/2), 710])
	color("lightblue") sink();
}

module kitchenWallsShort() {

	translate([125, 125, 80 + 120]) {

		// outside left
		translate([pergolaLength, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [120, 880, 640 + 120]);

		// inside right
		translate([880, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [120, 880, 640]);

		// inside most right
		translate([880 - 120, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [120, 880 + 120, 640]);



		// grill
		translate([880 + 120 + 367.5, 0, 0])
			union() {
				// right grill wall
				color([255/255, 255/255, 255/255]) cube(size = [120, 880, 640 + 840]);

				// left grill wall
				translate([1640 + 120, 0, 0])
				color([255/255, 255/255, 255/255]) cube(size = [120, 880, 640 + 840]);

				// back grill wall
				translate([0, -120, 840 - 120 - 120])
				color([255/255, 255/255, 255/255]) cube(size = [1640 + 120 + 120, 120, 640 + 120 + 120]);


				// inner grill
				translate([120, 0, 0])
				color([255/255, 255/255, 255/255]) cube(size = [120, 880, 600]);

				translate([1640, 0, 0])
				color([255/255, 255/255, 255/255]) cube(size = [120, 880, 600]);


				// reference block
				//ranslate([120, 0, 0])
				//color("blue") cube(size = [1880, 880, 640]);
			}


	}
}

module socket() {

	translate([5, 5, 0]) {
		// Fundament Ott
		color([140/255, 140/255, 140/255]) cube(size = [940, pergolaWidth + 120 + 60, 80]);


		// Fundament Fussballplatz
		color([140/255, 140/255, 140/255]) cube(size = [pergolaLength + 120 + 60, 940, 80]);
	}

}

module backWalls() {
	translate([5, 5, 80]) {
		// Fundament Ott
		color([205/255, 205/255, 205/255]) cube(size = [120, pergolaWidth + 120 + 120, 1200]);


		// Fundament Fussballplatz
		color([205/255, 205/255, 205/255]) cube(size = [pergolaLength + 120 + 120, 120, 1200]);
	}
}


module counterTopLong() {
	translate([125, 125, 80 + 120 + 640 + 120]) {
		// outside right
		translate([0, pergolaWidth - 880 - 120, 0])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 880 + 120 + 120 + 20, 40]);

		// roaring dragon
		translate([0, pergolaWidth - 880 - 500 - 120, -250])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 500, 40]);
		//color("blue") cube(size = [880, 500 + 120, 120]);

		// egg
		translate([0, 1540, -500])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 650, 40]);
		//color("blue") cube(size = [880, 650, 120]);

		// sink
		difference() {
			translate([0, pergolaWidth - 880 - 500 - 520 - 415 - 120 - 120 - 120 - 120, 0])
			color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 520 + 120 + 120 + 415 + 120, 40]);

			translate([0, -120, -800])
			translate([300, 3230-(450/2), 710])
			sinkOuter();
		}

		// egg left
		translate([0, 0, 0])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 1540, 40]);

	}
}


module counterTopShort() {
	translate([125, 125, 80 + 120 + 640 + 120]) {
		// left
		translate([pergolaLength - 367.5, 0, 0])
		color([0/255, 0/255, 0/255]) cube(size = [120 + 367.5 + 20, 880 + 20, 40]);

		// right
		translate([pergolaLength - (367.5 * 2) - 1640 - 120 - 120 - 120 - 880, 0, 0])
		color([0/255, 0/255, 0/255]) cube(size = [120 + 367.5 + 880, 880 + 20, 40]);
	}
}




translate([3855, 125, 80])
firePitFrame();

//cabinetFrame(length = 527);






// step 1 - pergola supports only
translate([floorLength, floorWidth, 0])
rotate([0, 0, 180])
color([205/255, 102/255, 29/255]) pergola();

// unified sink
//translate([125, 5, -50])
//unifiedSink();

// step 2 - socket
socket();


// step 3 - back walls
backWalls();


//// step 4 - kitchen floor
//kitchenFloor();



//// step 5 - kitchen walls
//kitchenWallsShort();
//
//// step 5a - kitchen walls long
//kitchenWallsLong();
//
//difference() {
//	// step 5b - counter tops short
//	lintelShort();
//
//	translate([220, 120 + 100, 810])
//	cube([3800, 700, 180]);
//}
//
//difference() {
//	// step 5c - counter tops long
//	lintelLong();
//
//	translate([220, 120 + 100, 810])
//	cube([700, 5700, 180]);
//}
//