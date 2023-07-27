include <../library/buttons.scad>








mirror([1,0,0]) {
    difference() {
        union() {
            cube(size = [80, 230, 2], center = false);

            // rifts
            translate([2, 2, 2]) cube(size = [76, 2, 6], center = false);
            translate([2, 226, 2]) cube(size = [76, 2, 6], center = false);
            


            translate([2, 2, 2]) cube(size = [2, 226, 6], center = false);
            translate([76, 2, 2]) cube(size = [2, 226, 6], center = false);




            // l-shift, l-ctrl and l-alt as switches
            translate([20, 20, 0]) buttonBasePocket(type = "switch");
            translate([40, 20, 0]) buttonBasePocket(type = "switch");
            translate([60, 20, 0]) buttonBasePocket(type = "switch");


            // F2, F3 and F4
            translate([20, 45, 0]) buttonBasePocket(type = "tactile");
            translate([20, 65, 0]) buttonBasePocket(type = "tactile");
            translate([20, 85, 0]) buttonBasePocket(type = "tactile");

            // F5 and F6
            translate([20, 115, 0]) buttonBasePocket(type = "tactile");
            translate([20, 135, 0]) buttonBasePocket(type = "tactile");

            // F7 and F9
            translate([20, 165, 0]) buttonBasePocket(type = "tactile");
            translate([20, 185, 0]) buttonBasePocket(type = "tactile");


            // F11 and F12
            translate([60, 45, 0]) buttonBasePocket(type = "tactile");
            translate([60, 65, 0]) buttonBasePocket(type = "tactile");

            // F1 and F10 including poti for map zoom
            translate([60, 185, 0]) buttonBasePocket(type = "adafruit");
            translate([60, 165, 0]) buttonBasePocket(type = "adafruit");
            translate([60, 145, 0]) buttonBasePocket(type = "default");

            // r-shift, r-ctrl and r-alt as switches
            translate([20, 210, 0]) buttonBasePocket(type = "switch");
            translate([40, 210, 0]) buttonBasePocket(type = "switch");
            translate([60, 210, 0]) buttonBasePocket(type = "switch");

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
        translate([20, 20, 0]) buttonBaseHole(type = "switch");
        translate([40, 20, 0]) buttonBaseHole(type = "switch");
        translate([60, 20, 0]) buttonBaseHole(type = "switch");


        // F2, F3 and F4
        translate([20, 45, 0]) buttonBaseHole(type = "tactile", socketHoles = true);
        translate([20, 65, 0]) buttonBaseHole(type = "tactile", socketHoles = true);
        translate([20, 85, 0]) buttonBaseHole(type = "tactile", socketHoles = true);

        // F5 and F6
        translate([20, 115, 0]) buttonBaseHole(type = "tactile", socketHoles = true);
        translate([20, 135, 0]) buttonBaseHole(type = "tactile", socketHoles = true);

        // F7 and F9
        translate([20, 165, 0]) buttonBaseHole(type = "tactile", socketHoles = true);
        translate([20, 185, 0]) buttonBaseHole(type = "tactile", socketHoles = true);


        // F11 and F12
        translate([60, 45, 0]) buttonBaseHole(type = "tactile", socketHoles = true);
        translate([60, 65, 0]) buttonBaseHole(type = "tactile", socketHoles = true);

        // F1 and F10 including poti for map zoom
        translate([60, 185, 0]) buttonBaseHole(type = "adafruit", socketHoles = true);
        translate([60, 165, 0]) buttonBaseHole(type = "adafruit", socketHoles = true);
        translate([60, 145, 0]) buttonBaseHole(type = "default", socketHoles = true);

        // r-shift, r-ctrl and r-alt as switches
        translate([20, 210, 0]) buttonBaseHole(type = "switch");
        translate([40, 210, 0]) buttonBaseHole(type = "switch");
        translate([60, 210, 0]) buttonBaseHole(type = "switch");
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
        translate([20, 20, 0]) buttonCoverHole(type = "switch");
        translate([40, 20, 0]) buttonCoverHole(type = "switch");
        translate([60, 20, 0]) buttonCoverHole(type = "switch");


        // F2, F3 and F4
        translate([20, 45, 0]) buttonCoverHole(type = "tactile");
        translate([20, 65, 0]) buttonCoverHole(type = "tactile");
        translate([20, 85, 0]) buttonCoverHole(type = "tactile");

        // F5 and F6
        translate([20, 115, 0]) buttonCoverHole(type = "tactile");
        translate([20, 135, 0]) buttonCoverHole(type = "tactile");

        // F7 and F9
        translate([20, 165, 0]) buttonCoverHole(type = "tactile");
        translate([20, 185, 0]) buttonCoverHole(type = "tactile");


        // F11 and F12
        translate([60, 45, 0]) buttonCoverHole(type = "tactile");
        translate([60, 65, 0]) buttonCoverHole(type = "tactile");

        // F1 and F10 including poti for map zoom
        translate([60, 185, 0]) buttonCoverHole(type = "adafruit");
        translate([60, 165, 0]) buttonCoverHole(type = "adafruit");
        translate([60, 145, 0]) buttonCoverHole(type = "default");

        // r-shift, r-ctrl and r-alt as switches
        translate([20, 210, 0]) buttonCoverHole(type = "switch");
        translate([40, 210, 0]) buttonCoverHole(type = "switch");
        translate([60, 210, 0]) buttonCoverHole(type = "switch");
    }
}