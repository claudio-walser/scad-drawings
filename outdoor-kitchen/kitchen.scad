include <../library/modules.scad>
include <./asado/assembly.scad>
include <./big-green-egg/large.scad>
include <../garden/pergola.scad>

// Fläche
cube(size = [3750, 5250, 10]);

module kitchen() {

	// Fundament Ott
	cube(size = [1000, 5250, 100]);

	// Wand Ott
	cube(size = [250, 5250, 1000]);

	// Korpus Ott
	translate([250, 0, 100])
	cube(size = [800, 5250, 900]);



	// Fundament Fussballplatz
	cube(size = [3750, 1000, 100]);

	// Küchenzeile Fussballplatz
	translate([0, 250, 100])
	cube(size = [3750, 800, 900]);
	// Wand Fussballplatz
	cube(size = [3750, 250, 1000]);
}

translate([3750 - outerWidth - spindleWallExtension - 500, spindleWallExtension, 850])
asadoFull();


//translate([floorLength, floorWidth, 0])
//rotate([0, 0, 180])
//pergola();

translate([400, 1200, 500])
largeEgg();

difference() {
	color([169/255, 169/255, 169/255]) kitchen();
	
	//scale( [1.15, 1.15, 1.15])
	//translate([315, 315, 500])
	//largeEgg();
	
	translate([315, 1185, 500])
	cube([850, 550, 550]);


	translate([3750 - outerWidth - (spindleWallExtension * 2) - (fireclayThickness) - (frameToWallGap) - 500, 100, 850])
	cube(size = [outerWidth + spindleWallExtension * 2 + (fireclayThickness * 2) + (frameToWallGap * 2), 1000, 900]);

	translate([3750 - outerWidth - (spindleWallExtension) - 500, 100, 850 - lintelThickness - 80 - fireclayThickness])
	cube(size = [outerWidth, 1000, 80]);




}
