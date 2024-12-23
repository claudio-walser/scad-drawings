include <BOSL/constants.scad>
use <BOSL/threading.scad>

$fn = 256;

difference() {
  cylinder(d=45, h=6);

  translate([0, 0, 5]) trapezoidal_threaded_rod(d=43, l=4, pitch=2, thread_angle=30);
  translate([0, 0, 1])cylinder(d=10.5, h=10);

}




!translate([60, 0, 0]) {
  
  difference() {
    union() {
      translate([0, 0, 0.5]) trapezoidal_threaded_rod(d=42, l=3, pitch=2, thread_angle=30);
      translate([0, 0, 2]) cylinder(d=45, h=2);
    }

    translate([0, 0, -2.5]) cylinder(d=38, h=6);
  }
}
