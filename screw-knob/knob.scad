include <../library/knob.scad>
$fn = 100;

translate([0, 0, 0]) {
	knob(true, 8);
	translate([0, 40, 0]) nutHolder(8);
}

translate([40, 0, 0]) {
	knob();
	translate([0, 40, 0]) nutHolder(8);

}
