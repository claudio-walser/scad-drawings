
cube(size=[2220, 6880, 10]);


thickness = 25;
depth = 100;

echo(str("Nr;Beschreibung;Stück;Länge;Breite;Dicke"));


module perch(width = 1000, height = 2000, number = 1) {

	//translate([0, depth*2, 0])
	//cube(size=[width, depth, height]);


	innerHeight = height - (2 * thickness);
	innerWidth = width - (2 * thickness);




	// left
	translate([0, 0, thickness])
	cube(size=[thickness, depth, innerHeight]);

	// right
	translate([width - thickness, 0, thickness])
	cube(size=[thickness, depth, innerHeight]);

   echo(str(number, ".1;Seiten ;", 2, ";", innerHeight, ";", depth, ";", thickness));


	// bottom
	cube(size=[width, depth, thickness]);

	// top
	translate([0, 0, height - thickness])
	cube(size=[width, depth, thickness]);
   echo(str(number, ".2;Oben/Unten ;", 2, ";", width, ";", depth, ";", thickness));


	gap = 51;
	amount = floor(innerHeight / (thickness + gap));
	translate([thickness, thickness, thickness])
	// inlays
	for ( i = [0 : amount - 1] ){
		translate([0, 0, (gap + thickness) * i])
		rotate([45, 0, 0])
		cube(size=[innerWidth, depth, thickness]);
	}
   echo(str(number, ".3;Lamellen ;", amount, ";", innerWidth, ";", depth, ";", thickness));

}



translate([100, 0, 0]) {
	translate([2120-780+35, 0, 0])
	perch(780-35, 2195, 2);

	perch(1320-35, 2360, 1);
}

widhtLarge = 1356;
translate([0, 6880, 0])
rotate([0, 0, -90]) {
	perch(widhtLarge, 2360, 3);

	translate([widhtLarge, 0, 0])
	perch(widhtLarge, 2360, 4);

	translate([widhtLarge*2, 0, 0])
	perch(widhtLarge, 2360, 5);

	translate([widhtLarge*3, 0, 0])
	perch(widhtLarge, 2360, 6);

	translate([widhtLarge*4, 0, 0])
	perch(widhtLarge, 2360, 7);
}

cube(size=[depth, depth, 2360]);
echo(str("8.1;Stützpfosten ;", 1, ";", 2360, ";", depth, ";", depth));
