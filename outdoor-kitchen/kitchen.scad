include <../library/modules.scad>
include <./asado/assembly.scad>
include <./big-green-egg/large.scad>
include <./sink/sink.scad>
include <./roaring-dragon/burner.scad>
include <../garden/pergola.scad>

// Fläche
cube(size = [3750, 5250, 10]);

// Abfluss 3230mm
// Waschbecken 450mm * 400mm

// Durchmesser 360
// Überstand 35
// Höhe 157
// Mitte -> Ventil 390


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


translate([floorLength, floorWidth, 0])
rotate([0, 0, 180])

// 205;102;29
color([205/255, 102/255, 29/255]) pergola();

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
