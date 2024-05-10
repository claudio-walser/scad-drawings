
$fn = 120;

// size reference
//translate([0, 500, 0]) cube(size=[510, 510, 840], center=false);
module largeEgg() {
	color([85/255, 107/255, 47/255]) translate([510/2, 510/2, 0])
	hull() {
		translate([0, 0, 840 - 510/2]) sphere(d = 510);
		linear_extrude(10) circle(d= 350);
	}
}