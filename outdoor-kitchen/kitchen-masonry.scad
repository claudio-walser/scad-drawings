include <../library/modules.scad>
include <./asado/assembly.scad>
include <./big-green-egg/large.scad>
include <./sink/sink.scad>
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

module kitchenFloor() {

	// // cutout for gas bottle if needed
	// translate([125, 125, 80]) {
	// 	difference() {
	// 		union() {
	// 			// Fundament Ott
	// 			color([205/255, 205/255, 205/255]) cube(size = [880, pergolaWidth + 120, 120]);
	// 			// Fundament Fussballplatz
	// 			color([205/255, 205/255, 205/255]) cube(size = [pergolaLength + 120, 880, 120]);
	// 		}


	// 		translate([0, pergolaWidth - 125 - 400, -50])
	// 		cube([400, 400, 300]);

	// 	}
	// }


	translate([125, 125, 80]) {
		// floor Ott
		color([225/255, 225/255, 225/255]) cube(size = [880, pergolaWidth + 120, 120]);
		// floor Fussballplatz
		color([225/255, 225/255, 225/255]) cube(size = [pergolaLength + 120, 880, 120]);
	}
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


module wallsRoaringDragon() {

		translate([0, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 120, 640 + 120]);


		// roaring dragon
		translate([0, 500 + 120, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 120, 640 + 120]);

		// reference
		//translate([0, 120, 0]) color("black") cube(size = [880, 500, 640 - 200]);


		// reference
		//translate([0, 900-120-40, 0]) color("red") cube(size = [880, 880, 640 - 200]);
}

module wallsEgg() {

		translate([0, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 120, 640 + 120]);


		// roaring dragon
		translate([0, 650 + 120, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 120, 640 + 120]);

		// reference
		//translate([0, 120, 0]) color("green") cube(size = [880, 650, 640 - 200]);
}

module kitchenWallsLong() {

	translate([125, 125, 80 + 120]) {
		// outside right
		translate([0, pergolaWidth, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 120, 640 + 120]);


		translate([0, pergolaWidth - 120 - 480 - 900 - 120, 0]) wallsRoaringDragon();

		translate([0, 880 + 420 + 120, 0])  wallsEgg();

		translate([0, 3230 - 500, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 120, 640]);


		// egg left


		// egg right

	}
}

module lintelLong() {
	translate([125, 125, 80 + 120 + 640]) {
		// outside right
		translate([0, pergolaWidth - 880 - 120, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 880 + 120 + 120, 120]);

		// roaring dragon
		translate([0, pergolaWidth - 880 - 500 - 120 - 120, -250])
		color([255/255, 255/255, 255/255]) cube(size = [880, 500 + 120, 120]);
		//color("blue") cube(size = [880, 500 + 120, 120]);

		// egg
		translate([0, 1540, -500])
		color([255/255, 255/255, 255/255]) cube(size = [880, 650, 120]);
		//color("blue") cube(size = [880, 650, 120]);

		// sink
		difference() {
			translate([0, pergolaWidth - 880 - 500 - 520 - 415 - 120 - 120 - 120 - 120, 0])
			color([255/255, 255/255, 255/255]) cube(size = [880, 520 + 120 + 120 + 415 + 120, 120]);

			translate([0, -120, -800])
			translate([300, 3230-(450/2), 710])
			sinkOuter();
		}

		// egg left
		translate([0, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [880, 1540, 120]);

	}
}


module lintelShort() {
	translate([125, 125, 80 + 120 + 640]) {
		// left
		translate([pergolaLength - 367.5, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [120 + 367.5, 880, 120]);

		// right
		translate([pergolaLength - (367.5 * 2) - 1640 - 120 - 120 - 120 - 880, 0, 0])
		color([255/255, 255/255, 255/255]) cube(size = [120 + 367.5 + 880, 880, 120]);

		// grill top
		translate([pergolaLength - 367.5 - 120 - 1640, 0, -120]) {
			color([255/255, 255/255, 255/255]) cube(size = [1640, 880, 80]);

			translate([0, 0, -120 - 80])
			color([255/255, 255/255, 255/255]) cube(size = [1640, 880, 120]);
			//color("blue") cube(size = [1640, 880, 120]);
		}
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


// step 4 - kitchen floor
kitchenFloor();


// step 5 - kitchen floor
kitchenFloor();


// step 6 - kitchen walls
kitchenWallsShort();

// step 6a - kitchen walls long
kitchenWallsLong();

difference() {
	// step 6b - counter tops short
	lintelShort();

	translate([220, 120 + 100, 810])
	cube([3800, 700, 180]);
}

difference() {
	// step 6c - counter tops long
	lintelLong();

	translate([220, 120 + 100, 810])
	cube([700, 5700, 180]);
}


//counterTopLong();
//counterTopShort();
//translate([pergolaLength - outerWidth - spindleWallExtension - 367.5 - 5 + 70, spindleWallExtension, 810])
//asadoFull();
//
//translate([400, 1210 + 410 + 125, 500])
//largeEgg();


/*

// Abfluss 3230mm
// Waschbecken 450mm * 400mm

// Durchmesser 360
// Überstand 35
// Höhe 157
// Mitte -> Ventil 390
color([176/255,196/255,222/255])


translate([430, 4960, 225]) {
	gasBottle();
}

module kitchen() {

	// Fundament Ott
	color([140/255, 140/255, 140/255]) cube(size = [1000, 5250, 100]);

	// Wand Ott
	color([169/255, 169/255, 169/255]) cube(size = [125, 5250, 1200]);

	// Korpus Ott
	translate([125, 0, 100])
	color([169/255, 169/255, 169/255]) cube(size = [925, 5250, 900]);



	// Fundament Fussballplatz
	color([140/255, 140/255, 140/255]) cube(size = [3750, 1000, 100]);

	// Küchenzeile Fussballplatz
	translate([0, 125, 100])
	color([169/255, 169/255, 169/255]) cube(size = [3750, 925, 900]);
	// Wand Fussballplatz
	color([169/255, 169/255, 169/255]) cube(size = [3750, 125, 1200]);
}

translate([3750 - outerWidth - spindleWallExtension - 500, spindleWallExtension, 850])
asadoFull();




translate([400, 1210 + 550 + 125, 500])
largeEgg();

// Abfluss Rohr
translate([625, 3230, 0])
color("green") cylinder(h=700, r=80);

difference() {
	kitchen();

	//scale( [1.15, 1.15, 1.15])
	//translate([315, 315, 500])
	//largeEgg();

	// Egg
	translate([125, 1185 + 550 + 125, 500])
	cube([950, 550, 550]);

	// Egg mitte
	translate([125, 1185 + 550 + 125, 225])
	cube([950, 550, 335 - 125 - 60]);

	// Egg rechts
	translate([125, 1185, 225])
	cube([950, 550, 835 - 185]);


	// Waschbecken
	translate([400, 3230-(450/2), 710])
	sink();



	// Waschbecken mitte
	translate([125, 1735 + 550 + 125 + 125, 225])
	cube([950, 1400, 835 - 185]);

	// Wok-Brenner
	translate([905 - (390 - ((360 - 70) / 2)), 4000 + ((1190) / 2), 845])
	burner();

	// Wok Brenner Mitte
	translate([125, 1735 + 550 + 1400 + (125 * 3), 225])
	cube([950, 1190 - 125, 835 - 185]);

	// Feuerstelle
	translate([3750 - outerWidth - (spindleWallExtension * 2) - (fireclayThickness) - (frameToWallGap) - 500, 100, 850])
	cube(size = [outerWidth + spindleWallExtension * 2 + (fireclayThickness * 2) + (frameToWallGap * 2), 1000, 900]);

	// Feuerstelle links
	translate([3750 - 425, 100, 225]) {
		cube(size = [300, 1000, 835 - 185]);
	}

	// Feuerstelle mitte inkl, Ascheschublade
	translate([3750 - outerWidth - (spindleWallExtension) - 500 + profileSize, 100, 850 - lintelThickness - 80 - fireclayThickness]) {
		cube(size = [outerWidth - (profileSize * 2), 1000, 80]);
		
		translate([0, 0, -440])
		cube(size = [outerWidth - (profileSize * 2), 1000, 375]);
	}

	// Feuerstelle rechts
	translate([3750 - outerWidth - spindleWallExtension - fireclayThickness - frameToWallGap - 125 - 500 - 380 + 125, 100, 225]) {
		cube(size = [380 - 125, 1000, 835 - 185]);
	}

}
*/