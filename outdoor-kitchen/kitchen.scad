include <../library/modules.scad>
include <./asado/assembly.scad>
include <./big-green-egg/large.scad>
include <./sink/sink.scad>
include <./cabinets/cabinets.scad>
include <./roaring-dragon/burner.scad>
include <../garden/pergola.scad>
include <./models/gas-bottle.scad>


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
	translate([5, 5, 0]) {
		// Fundament Ott
		color("grey") cube(size = [backWallThickness, pergolaWidth + backWallThickness + backWallThickness, 1620]);


		// Fundament Fussballplatz
		color("grey") cube(size = [pergolaLength + backWallThickness + backWallThickness, backWallThickness, 1620]);
	}
}


module counterTopLong() {
	translate([125, 125, 950]) {
		// outside right
		translate([0, pergolaWidth - 545 - 20, 0])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 670 + 35, 40]);

		// roaring dragon
		translate([0, 1450 + 650 + 880 + 575 - 15, -250])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 900, 40]);
		//color("blue") cube(size = [880, 500 + 120, 120]);

		// egg
		translate([0, 1450, -500])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 650, 40]);
		//color("blue") cube(size = [880, 650, 120]);

		// sink
		difference() {
			translate([0, 1450 + 650 - 15, 0])
			color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 880 + 575 + 15, 40]);

			translate([0, -120, -800])
			translate([300, 3230-(450/2), 710])
			sinkOuter();
		}

		// egg left
		translate([0, 0, 0])
		color([0/255, 0/255, 0/255]) cube(size = [880 + 20, 1450 + 15, 40]);

	}
}


module counterTopShort() {
	translate([125, 125, 950]) {
		// left
		translate([pergolaLength - 412.5, 0, 0])
		color([0/255, 0/255, 0/255]) cube(size = [120 + 367.5 + 60, 880 + 20, 40]);

		// right
		translate([0, 0, 0])
		color([0/255, 0/255, 0/255]) cube(size = [120 + 367.5 + 880 + 35, 880 + 20, 40]);
	}
}


module cabinetsShortSide() {

	translate([backWallFullLength - grillSideCabinetWidth, 0, 0])
	cabinetFrame(length = grillSideCabinetWidth);

	translate([backWallFullLength - grillSideCabinetWidth - grillWallDistance - 2 * grillWallThickness - grillSideCabinetWidth, 0, 0])
	cabinetFrame(length = grillSideCabinetWidth);

}

module cabinetsLongSide() {
	cabinetFrame(length = 880);

	translate([880, 0, 0])
	cabinetFrame(length = 570);

	translate([880 + 570, 0, 0])
	cabinetFrame(length = 650, height = 880 - 500);

	translate([880 + 570 + 650, 0, 0])
	cabinetFrame(length = 570);

	translate([880 + 570 + 650 + 570, 0, 0])
	cabinetFrame(length = 870);

	translate([880 + 570 + 650 + 570 + 870, 0, 0])
	cabinetFrame(length = 900, height = 880 - 250);

	translate([880 + 570 + 650 + 570 + 870 + 900, 0, 0])
	cabinetFrame(length = 670);
}

module grillWalls(fireclay = true, asado = true) {
	width = 880;
	translate([0, 0, 0]) {
		// grill
		//translate([880 + 120 + 367.5, 0, 0])
		translate([0, 0, 0]) {
			union() {
				// right grill wall
				color("darksalmon") cube(size = [grillWallThickness, 880, 640 + 980]);

				// left grill wall
				translate([grillWallDistance + grillWallThickness, 0, 0])
				color("darksalmon") cube(size = [grillWallThickness, 880, 640 + 980]);

				// back grill wall
				//translate([0, -120, 840 - 120 - 120])
				//color([255/255, 255/255, 255/255]) cube(size = [1640 + 120 + 120, 120, 640 + 120 + 120]);

				//// inner grill
				//translate([120, 0, 0])
				//color([155/255, 155/255, 155/255]) cube(size = [120, 880, 600 + 140]);

				//translate([1640, 0, 0])
				//color([155/255, 155/255, 155/255]) cube(size = [120, 880, 600 + 140]);

				// reference block
				translate([grillWallThickness + 30, 30, 660 + frameBeamWidth + 140 - 30])
				color("blue") cube(size = [1580, 880 - 30, 770]);
			}
		}

		translate([0, 0, 640 + 140 + 80]) {
			// grill top
			translate([0, 0, -120]) {
				color([255/255, 255/255, 255/255]) cube(size = [1880, 880, 80]);

				//translate([0, 0, -120 - 40])
				//color([255/255, 255/255, 255/255]) cube(size = [1880, 880, 80]);
				//color("blue") cube(size = [1640, 880, 120]);
			}
		}
	}

	if (asado) {
		translate([160 + 30, 30, 850])
		asadoFull();
	}

	if (fireclay) {
		// fireclay
		translate([40, -35, 40])
		color("lightyellow") {
			// back plate
			translate([frameBeamWidth, frameBeamWidth / 4 + 15, 660 + frameBeamWidth])
			cube([grillFrameWidth - (frameBeamWidth * 2), 30, 840]);
    		
			echo(str("10.1,Schamott-Rückwand", ",", "1", ",", grillFrameWidth - (frameBeamWidth * 2), ",", 840, ",", 30));

			// bottom plate
			translate([frameBeamWidth, frameBeamWidth-15, 700 + frameBeamWidth])
			cube([grillFrameWidth - (frameBeamWidth * 2), width - frameBeamWidth + 50, 30]);
			echo(str("10.2,Schamott-Boden", ",", "1", ",", grillFrameWidth - (frameBeamWidth * 2), ",", width - frameBeamWidth + 50, ",", 30));

			// right plate
			translate([frameBeamWidth, frameBeamWidth - 15, 660 + frameBeamWidth+30])
			cube([30, width - (frameBeamWidth) + 50, 840 - frameBeamWidth+50]);
			echo(str("10.2,Schamott-Seiten", ",", "2", ",", width - (frameBeamWidth) + 50, ",", 840, ",", 30));

			//// left plate
			//translate([grillFrameWidth-frameBeamWidth, frameBeamWidth, 660 + frameBeamWidth])
			translate([grillFrameWidth-frameBeamWidth-30, frameBeamWidth - 15, 660 + frameBeamWidth+30])
			cube([30, width - (frameBeamWidth) + 50, 840 - frameBeamWidth+50]);
		}
	}
}

showSocket = true;
showWalls = true;
showLongSide = true;
showShortSide = true;
showCounterTops = true;

fireclay = true;
fermacell = true;
asado = false;

grillWallDistance = outerWidth + 2 * 40 + 2 * 30;

// configs
backWallThickness = 120;
grillWallThickness = 120;
grillSideCabinetWidth = 527.5;
backWallFullWidth = pergolaWidth + 2 * backWallThickness;
backWallFullLength = pergolaLength + 2 * backWallThickness;
socketHeight = 80;
// Fläche
cube(size = [floorLength, floorWidth, 10]);

// step 1 - pergola supports only
translate([floorLength, floorWidth, 0])
rotate([0, 0, 180])
color([205/255, 102/255, 29/255]) pergola();

// step 2 - socket
if (showSocket) {
	socket();
}
if (showWalls) {
	// step 3 - back walls
	backWalls();

	translate([backWallFullLength - grillFrameWidth - grillSideCabinetWidth - 75, 125, 0]) {


		grillWalls(fireclay, asado);
	}
}

if (showLongSide) {
	// unified sink
	translate([125, 5, -50])
	unifiedSink();

	translate([400, 1210 + 435 , 880 - 420 + 15])
	largeEgg();

	translate([430, 4960, 175]) {
		gasBottle();
	}

	translate([1000, 125, 80]) {
		rotate([0, 0, 90]){
			cabinetsLongSide();
		}
	}
	if (showCounterTops) {
		counterTopLong();

	}
}

if (showShortSide) {
	translate([0, backWallThickness, socketHeight]) {
		cabinetsShortSide();
	}
	if (showCounterTops) {
		counterTopShort();
	}
	// Material Lärche 80*80
	// 32lm Aufrecht
	// 20lm Lange Seite
	// 12lm Kurze Seite
	// insgesamt 65 Laufmeter Lärche 80*80
}
