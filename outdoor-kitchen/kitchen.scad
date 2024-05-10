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






// Küchenzeile Ott
difference() {

	color([169/255, 169/255, 169/255]) kitchen();
	scale( [1.15, 1.15, 1.15])
	translate([315, 315, 500])
	largeEgg();


	translate([3750 - outerWidth - spindleWallExtension * 2 - 500, 100, 850])
	cube(size = [outerWidth + spindleWallExtension * 2, 1000, 900]);

}


translate([3750 - outerWidth - spindleWallExtension - 500, spindleWallExtension, 850])
asadoFull();

pergola();

translate([400, 400, 500])
largeEgg();

// // Wand Rasen
// translate([3500, 0, 0])
// cube(size = [250, 3750, 1200]);

// // Fundament Rasen
// translate([2750, 0, 0])
// cube(size = [1000, 3750, 100]);

// // Küchenzeile Rasen
// translate([2700, 0, 100])
// cube(size = [800, 3750, 900]);





// // Fundament Strasse
// translate([0, 5250-1000, 0])
// cube(size = [3750, 1000, 100]);

// // Wand Strasse
// translate([0, 5250-250, 0])
// cube(size = [3750, 250, 1800]);

// // Küchenzeile Strasse
// translate([0, 5250-800-250, 100])
// cube(size = [3750, 800, 900]);
