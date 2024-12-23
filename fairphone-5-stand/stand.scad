
height = 166;
width = 79.6;
thickness = 12;

// loading cable in the middle of both directions
difference() {
  union() {
    cube([90, 25, 40]);
    translate([0, -30, 0]) cube([90, 40, 15]);
  }
  
  translate([5, 10, 15])
  rotate([10, 0, 0])
  cube([width, thickness, height]);

  translate([(width + 10) / 2, 19, -5])
  rotate([10, 0, 0])
  translate([0,0,-20])
  cylinder(d = 10, h = 80);


  translate([(width + 10) / 2, 19, 7])
  rotate([100, 0, 0])
  cylinder(d = 10, h = 50);

  translate([7, 15, 20])
  cube([width - 4, thickness, height]);
}

