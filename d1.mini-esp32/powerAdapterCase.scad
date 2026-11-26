$fn = 256;

d1Width = 26;
d1Length = 34.4;
d1Thickness = 8;
d1BoardThickness = 1.2;

d1ChipWidth = 12;
d1ChipLength = 15;
d1ChipThickness = (d1Thickness - d1BoardThickness) / 2;

powerAdapterWidth = 40.2;
powerAdapterLength = 45.7;
powerAdapterThickness = 28.1;

wallThickness = 3;
cableSpaceAddition = 20;




module esp32() {
	union() {
		color("green") cube([d1Width, d1Length, d1BoardThickness]);

		translate([(d1Width - d1ChipWidth) / 2, 7.5, 0])
		color("silver") cube([d1ChipWidth, d1ChipLength, d1ChipThickness]);

		translate([(d1Width - 7) / 2, d1Length - 9 + 2, -3])
		color("silver") cube([7, 9, 3]);
	}
}

module esp32Space () {
	cube([d1Thickness * 2 + wallThickness * 2, powerAdapterLength - wallThickness * 2 + cableSpaceAddition * 2, powerAdapterThickness]);
}


module powerAdapter() {

	color("white") cube([powerAdapterWidth, powerAdapterLength + wallThickness * 3, powerAdapterThickness]);
}

module powerAdapterSpace() {

	color("white") cube([powerAdapterWidth, powerAdapterLength + wallThickness * 3 + cableSpaceAddition, powerAdapterThickness]);
}

module screwSocket() {

	difference() {
		hull() {
			cube([0.1, 0.1, 8]);

			translate([6, 0, 0])
			cube([0.1, 8, 8]);
		}

		translate([8/2 - 1, 10, 8/2])
		rotate([90,0,0])
		cylinder(d=3, h=20);
	}
}

difference() {
	//translate([0, - 20, 0])
	color("red") cube([powerAdapterWidth + wallThickness * 2 + d1Thickness + wallThickness, powerAdapterLength + wallThickness * 2 + cableSpaceAddition, powerAdapterThickness + wallThickness * 2]);
	
	translate([wallThickness, wallThickness, wallThickness]) {
		powerAdapterSpace();
	}

	translate([powerAdapterWidth, wallThickness, wallThickness])
	esp32Space();

}


translate([powerAdapterWidth + wallThickness * 2 + d1Thickness, wallThickness * 2, 6 + wallThickness])
rotate([0, 90, 90]) {
	screwSocket();

	translate([0, 0, powerAdapterLength + cableSpaceAddition / 2 - wallThickness])
	screwSocket();
}



mirror([0, 0, 1])
translate([powerAdapterWidth + wallThickness * 2 + d1Thickness, wallThickness * 2, - powerAdapterThickness - wallThickness + 8 - wallThickness])
rotate([0, 90, 90]) {
	screwSocket();

	translate([0, 0, powerAdapterLength + cableSpaceAddition / 2 - wallThickness])
	screwSocket();
}




//translate([wallThickness, wallThickness + cableSpaceAddition, wallThickness]) {
//	powerAdapter();
//	translate([powerAdapterWidth + 8, powerAdapterLength - 10, d1Width + 1.5])
//	rotate([0, 90, 180])
//	esp32();
//}

//powerAdapter();
//translate([powerAdapterWidth + 8, powerAdapterLength - d1Length, d1Width + 1.5])
//rotate([0, 90, 0])
//esp32();