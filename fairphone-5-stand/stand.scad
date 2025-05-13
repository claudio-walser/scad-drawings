
height = 166;
width = 79.6;
thickness = 12;



usbWidth = 12.5; // 12
usbHeight = 7; // 6.5
usbLength = 21; // 20.5


usbPlugWidth = 8.2;
usbPplugHeight = 2.3;
usbPplugLength = 9;

usbPplugOverlap = 2;


module usbPlug() {

  // Reference Cube
  translate([0, -usbHeight/2-1, 0])
  cube([usbWidth, usbHeight/2+1, usbLength]);

  // Plug Body
  translate([usbHeight/2, 0, 0]) {
    hull() {
      cylinder(d=usbHeight, h=usbLength, $fn=248);

      translate([usbWidth - usbHeight, 0, 0])
      cylinder(d=usbHeight, h=usbLength, $fn=248);
    }
  }

  
  // Plug
  rotate([90, 0, 0]) {
    translate([(usbPplugHeight/2) + ((usbWidth - usbPlugWidth)/2), (usbPplugHeight/2) + usbPplugOverlap, usbHeight/2]) {
      hull() {
        cylinder(d=usbPplugHeight, h=usbPplugLength, $fn=248);

        translate([usbPlugWidth - usbPplugHeight, 0, 0])
        cylinder(d=usbPplugHeight, h=usbPplugLength, $fn=248);
      }
    }
  }
}

module usbPlugHole() {
  // Reference Cube
  translate([0, -usbHeight/2-1, 0])
  cube([usbWidth, usbHeight/2+1, usbLength]);

  // Plug Body
  translate([usbHeight/2, 0, 0]) {
    hull() {
      cylinder(d=usbHeight, h=usbLength + 60, $fn=248);

      translate([usbWidth - usbHeight, 0, 0])
      cylinder(d=usbHeight, h=usbLength + 60, $fn=248);
    }
  }

  rotate([-20, 0, 0]) {
    translate([0, -usbHeight/2-4, 4])
    cube([usbWidth, usbHeight/2+4, usbLength + 4]);


    translate([usbHeight/2, -1, 4]) {
      hull() {
        cylinder(d=usbHeight, h=usbLength + 4, $fn=248);

        translate([usbWidth - usbHeight, 0, 0])
        cylinder(d=usbHeight, h=usbLength + 4, $fn=248);
      }
    }
  }

  
  // Plug
  rotate([90, 0, 0]) {
    translate([(usbPplugHeight/2) + ((usbWidth - usbPlugWidth)/2), (usbPplugHeight/2) + usbPplugOverlap, usbHeight/2]) {
      hull() {
        cylinder(d=usbPplugHeight, h=usbPplugLength, $fn=248);

        translate([usbPlugWidth - usbPplugHeight, 0, 0])
        cylinder(d=usbPplugHeight, h=usbPplugLength, $fn=248);
      }
    }
  }
}



//usbPlugHole();

// loading cable in the middle of both directions
difference() {
  // stand
  union() {
    cube([90, 25, 40]);
    translate([0, -30, 0]) cube([90, 40, 15]);
  }
  
  // phone
  translate([5, 10, 15])
  rotate([10, 0, 0])
  cube([width, thickness, height]);


  // plug
  translate([12.5, 0, 7/2])
  translate([width / 2 -1.2, 19, 9.5])
  rotate([-99.5, 0, 180])
  usbPlugHole();
  //usbPlug();

  //translate([(width + 10) / 2, 19, -5])
  //rotate([10, 0, 0])
  //translate([0,0,-20])
  //cylinder(d = 10, h = 80);


  //translate([(width + 10) / 2, 19, 7])
  //rotate([100, 0, 0])
  //cylinder(d = 10, h = 50);

  // front opening
  translate([7, 15, 20])
  cube([width - 4, thickness, height]);
}

