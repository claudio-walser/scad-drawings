include <BOSL/constants.scad>
use <BOSL/threading.scad>

$fn = 256;

difference() {
  cylinder(d=42, h=5);

  translate([0, 0, 5]) trapezoidal_threaded_rod(d=40, l=4, pitch=1, thread_angle=15);
  translate([0, 0, 1])cylinder(d=10.5, h=10);

}




translate([60, 0, 0]) {
  
  difference() {
    union() {
      translate([0, 0, 2]) trapezoidal_threaded_rod(d=40, l=2, pitch=1, thread_angle=15);
      cylinder(d=42, h=1);
    }

    translate([0, 0, 1]) cylinder(d=38, h=5);
  }
}
