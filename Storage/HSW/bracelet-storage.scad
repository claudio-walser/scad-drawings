
hsw_insert_diameter = 15.35;
hsw_insert_depth = 10.5;
hsw_chamfer_h = 0.5;

e = 0.001;

module circ_chamfer(r, h) {
    r2 = r-h/tan(45);
    translate([0,0,-h/2+e]) difference() {
        cylinder(r=r+2*e, h=h, center=true);
        cylinder(r1=r, r2=r2, h=h+2*e, center=true);
    }
}

module pin() {
	translate([hsw_insert_diameter / 2, hsw_insert_diameter / 2, 0])
	difference() {
		cylinder(d=hsw_insert_diameter, h=hsw_insert_depth, $fn=6);

	    translate([0,0,hsw_insert_depth])
	    circ_chamfer(hsw_insert_diameter/2, hsw_chamfer_h, $fn=6);

	    mirror([0,0,1])
	    circ_chamfer(hsw_insert_diameter/2+e, hsw_chamfer_h, $fn=6);
	}
}

translate([-8, -8, -12])
pin();
//translate([100, 0, 0])
//pin();




cube([40,40,4], center = true);

translate([0, 0, 20]) {    
    difference() {
        rotate([0, 90, 0])
        cube([40, 40, 8], center = true);
        
        translate([0, 20, 20])
        rotate([45, 0, 0])
        cube([40,40,40], center = true);

        translate([0, -15, 0])
        rotate([0, 90, 0])
        cylinder(d = 22, h=10, center=true);
        translate([0, -25, 0])
        cube([20, 20, 22], center = true);
    }
}
