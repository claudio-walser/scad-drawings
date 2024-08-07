include <../library/modules.scad>
include <./asado/assembly.scad>
include <./big-green-egg/large.scad>
include <../garden/pergola.scad>

// Fläche
cube(size = [3750, 5250, 10]);

// Abfluss 3230mm
// Waschbecken 450mm * 400mm

module kitchen() {

	// Fundament Ott
	color([255/255, 123/255, 69/255]) cube(size = [1000, 5250, 100]);

	// Wand Ott
	color([169/255, 169/255, 169/255]) cube(size = [125, 5250, 1200]);

	// Korpus Ott
	translate([125, 0, 100])
	color([169/255, 169/255, 169/255]) cube(size = [925, 5250, 900]);



	// Fundament Fussballplatz
	color([255/255, 123/255, 69/255]) cube(size = [3750, 1000, 100]);

	// Küchenzeile Fussballplatz
	translate([0, 125, 100])
	color([169/255, 169/255, 169/255]) cube(size = [3750, 925, 900]);
	// Wand Fussballplatz
	color([169/255, 169/255, 169/255]) cube(size = [3750, 125, 1200]);

	// Abfluss Rohr
	translate([625, 3230, 0])
	color("green") cylinder(h=2000, r=80);
}

translate([3750 - outerWidth - spindleWallExtension - 500, spindleWallExtension, 850])
asadoFull();


//translate([floorLength, floorWidth, 0])
//rotate([0, 0, 180])
//pergola();

translate([400, 1200, 500])
largeEgg();

difference() {
	kitchen();
	
	//scale( [1.15, 1.15, 1.15])
	//translate([315, 315, 500])
	//largeEgg();
	
	// Egg
	translate([125, 1185, 500])
	cube([950, 550, 550]);

	// Egg mitte
	translate([125, 1185, 225])
	cube([950, 550, 335 - 125 - 60]);
	
	// Egg rechts
	translate([125, 1735 + 125, 225])
	cube([950, 550, 835 - 185]);




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
	translate([3750 - outerWidth - spindleWallExtension - fireclayThickness - frameToWallGap - 125 - 500 - 300, 100, 225]) {
		cube(size = [300, 1000, 835 - 185]);
	}

}
