include <../library/buttons.scad>
include <../library/modules.scad>


mirror([1,0,0]) {
    difference() {
        union() {
            cube(size = [80, 230, 2], center = false);
            // rifts
            translate([2, 2, 2]) cube(size = [76, 3, 6], center = false);
            translate([2, 225, 2]) cube(size = [76, 3, 6], center = false);
            
            translate([2, 2, 2]) cube(size = [3, 226, 6], center = false);
            translate([75, 2, 2]) cube(size = [3, 226, 6], center = false);

            // F2, F3 and F4
            translate([20, 45, 0]) buttonBasePocket(type = "button-adafruit-1119");
            translate([20, 65, 0]) buttonBasePocket(type = "button-adafruit-1119");
            translate([20, 85, 0]) buttonBasePocket(type = "button-adafruit-1119");

            // F5 and F6
            translate([20, 115, 0]) buttonBasePocket(type = "button-adafruit-1119");
            translate([20, 135, 0]) buttonBasePocket(type = "button-adafruit-1119");

            // F7 and F9
            translate([20, 165, 0]) buttonBasePocket(type = "button-adafruit-1119");
            translate([20, 185, 0]) buttonBasePocket(type = "button-adafruit-1119");


            // F11 and F12
            translate([60, 45, 0]) buttonBasePocket(type = "button-adafruit-1119");
            translate([60, 65, 0]) buttonBasePocket(type = "button-adafruit-1119");

            // F1 and F10 including poti for map zoom
            translate([60, 185, 0]) buttonBasePocket(type = "button-adafruit-1009");
            translate([60, 165, 0]) buttonBasePocket(type = "button-adafruit-1009");

            // screw holes
            translate([0, 0, -1]) {
                // left
                translate([10, 10, 1]) cylinder(d = 6, h = 10, $fn = 100);
                translate([70, 10, 1]) cylinder(d = 6, h = 10, $fn = 100);

                // middle
                translate([10, 100, 1]) cylinder(d = 6, h = 10, $fn = 100);
                translate([70, 115, 1]) cylinder(d = 6, h = 10, $fn = 100);
                translate([10, 150, 1]) cylinder(d = 6, h = 10, $fn = 100);

                translate([40, 80, 1]) cylinder(d = 6, h = 10, $fn = 100);
                translate([40, 160, 1]) cylinder(d = 6, h = 10, $fn = 100);

                // right
                translate([10, 220, 1]) cylinder(d = 6, h = 10, $fn = 100);
                translate([70, 220, 1]) cylinder(d = 6, h = 10, $fn = 100);
            }
        }

        rotate([0, 90, 0]) {
            translate([-5, 20, -5]) cylinder(d = 2.7, h = 90, $fn = 100);
            translate([-5, 210, -5]) cylinder(d = 2.7, h = 90, $fn = 100);
            
            translate([-5, 115, -5]) cylinder(d = 2.7, h = 11, $fn = 100);
            translate([-5, 115, 74]) cylinder(d = 2.7, h = 11, $fn = 100);
        
        }

        // screw holes
        translate([0, 0, -1]) {
            // left
            translate([10, 10, 0]) cylinder(d = 2.7, h = 30, $fn = 100);
            translate([70, 10, 0]) cylinder(d = 2.7, h = 30, $fn = 100);

            // middle
            translate([10, 100, 0]) cylinder(d = 2.7, h = 30, $fn = 100);
            translate([70, 115, 0]) cylinder(d = 2.7, h = 30, $fn = 100);
            translate([10, 150, 0]) cylinder(d = 2.7, h = 30, $fn = 100);

            translate([40, 80, 0]) cylinder(d = 2.7, h = 30, $fn = 100);
            translate([40, 160, 0]) cylinder(d = 2.7, h = 30, $fn = 100);

            // right
            translate([10, 220, 0]) cylinder(d = 2.7, h = 30, $fn = 100);
            translate([70, 220, 0]) cylinder(d = 2.7, h = 30, $fn = 100);

        }

        // l-shift, l-ctrl and l-alt as switches
        translate([20, 20, 0]) buttonBaseHole(type = "switch-submini");
        translate([40, 20, 0]) buttonBaseHole(type = "switch-submini");
        translate([60, 20, 0]) buttonBaseHole(type = "switch-submini");

        // F2, F3 and F4
        translate([20, 45, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);
        translate([20, 65, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);
        translate([20, 85, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);

        // F5 and F6
        translate([20, 115, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);
        translate([20, 135, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);

        // F7 and F9
        translate([20, 165, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);
        translate([20, 185, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);


        // F11 and F12
        translate([60, 45, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);
        translate([60, 65, 0]) buttonBaseHole(type = "button-adafruit-1119", socketHoles = true);

        // F1 and F10 including poti for map zoom
        translate([60, 185, 0]) buttonBaseHole(type = "button-adafruit-1009", socketHoles = true);
        translate([60, 165, 0]) buttonBaseHole(type = "button-adafruit-1009", socketHoles = true);
        translate([60, 145, 0]) buttonBaseHole(type = "default");

        // r-shift, r-ctrl and r-alt as switches
        translate([20, 210, 0]) buttonBaseHole(type = "switch-submini");
        translate([40, 210, 0]) buttonBaseHole(type = "switch-submini");
        translate([60, 210, 0]) buttonBaseHole(type = "switch-submini");
    }
}



// faceplate
mirror([1,0,0]) {
    translate([100, 0, 0])
    difference() {
        cube(size = [80, 230, 1], center = false);

        // screw holes
        translate([0, 0, -1]) {
            // left
            translate([10, 10, 0]) cylinder(d = 3.1, h = 30, $fn = 100);
            translate([70, 10, 0]) cylinder(d = 3.1, h = 30, $fn = 100);

            // middle
            translate([10, 100, 0]) cylinder(d = 3.1, h = 30, $fn = 100);
            translate([70, 115, 0]) cylinder(d = 3.1, h = 30, $fn = 100);
            translate([10, 150, 0]) cylinder(d = 3.1, h = 30, $fn = 100);

            translate([40, 80, 0]) cylinder(d = 3.1, h = 30, $fn = 100);
            translate([40, 160, 0]) cylinder(d = 3.1, h = 30, $fn = 100);

            // right
            translate([10, 220, 0]) cylinder(d = 3.1, h = 30, $fn = 100);
            translate([70, 220, 0]) cylinder(d = 3.1, h = 30, $fn = 100);

        }

        // l-shift, l-ctrl and l-alt as switches
        translate([20, 20, 0]) buttonCoverHole(type = "switch-submini");
        translate([40, 20, 0]) buttonCoverHole(type = "switch-submini");
        translate([60, 20, 0]) buttonCoverHole(type = "switch-submini");

        // F2, F3 and F4
        translate([20, 45, 0]) buttonCoverHole(type = "button-adafruit-1119");
        translate([20, 65, 0]) buttonCoverHole(type = "button-adafruit-1119");
        translate([20, 85, 0]) buttonCoverHole(type = "button-adafruit-1119");

        // F5 and F6
        translate([20, 115, 0]) buttonCoverHole(type = "button-adafruit-1119");
        translate([20, 135, 0]) buttonCoverHole(type = "button-adafruit-1119");

        // F7 and F9
        translate([20, 165, 0]) buttonCoverHole(type = "button-adafruit-1119");
        translate([20, 185, 0]) buttonCoverHole(type = "button-adafruit-1119");

        // F11 and F12
        translate([60, 45, 0]) buttonCoverHole(type = "button-adafruit-1119");
        translate([60, 65, 0]) buttonCoverHole(type = "button-adafruit-1119");

        // F1 and F10 including poti for map zoom
        translate([60, 185, 0]) buttonCoverHole(type = "button-adafruit-1009");
        translate([60, 165, 0]) buttonCoverHole(type = "button-adafruit-1009");
        translate([60, 145, 0]) buttonCoverHole(type = "default");

        // r-shift, r-ctrl and r-alt as switches
        translate([20, 210, 0]) buttonCoverHole(type = "switch-submini");
        translate([40, 210, 0]) buttonCoverHole(type = "switch-submini");
        translate([60, 210, 0]) buttonCoverHole(type = "switch-submini");
    }
}



! rotate([0, 0, 90]) {
    translate([115, -100, 0]) {
        union() {
            difference() {
                box(50, 226, 76, 2, open = "front");
                rotate([22.5, 0, 0]) translate([0, 50, 30]) cube(size = [270, 80, 120], center = true);
            }

            translate([0, 18.5, 7.6]) {
                rotate([45, 0, 0]) {
                        difference() {
                            box(50, 226, 76, 2, open = "front");
                            rotate([-22.5, 0, 0]) translate([0, -50, 30]) cube(size = [270, 80, 120], center = true);
                        }
                }
            }
        }
    }
}
