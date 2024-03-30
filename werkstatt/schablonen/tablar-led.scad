
// 65mm Lochdurchmesser, 2mm zum Anlaufring, 8mm dick
// brettli 175mm * 103mm
$fn = 4000;
// led
//difference() {
//	cube(size=[175+40, 103+40, 8]);
//	translate([(175+40)/2, (103+40)/2, -10]) cylinder(d=69, h=100);
//}
//cube(size=[175+30, 20, 40]);
//cube(size=[20, 103+30, 40]);


// glas
//translate([300, 0, 0]) {
	difference() {
		cube(size=[175+40, 103+40, 8]);
		translate([(175+40)/2, (103+40)/2, -10]) cylinder(d=79, h=100);
	}
	cube(size=[175+30, 20, 40]);
	cube(size=[20, 103+30, 40]);
//}