// types = {
//    default
//    button-adafruit-1119
//    button-adafruit-1009
//    switch-submini
// }


module buttonCoverHole(type = "default") {
    translate([0, 0, -1])
    if (type == "button-adafruit-1009") {
        cylinder(d = 11.6, h = 10, $fn = 100);
    } else if (type == "button-adafruit-1119") {
        cylinder(d = 6.8, h = 10, $fn = 100);
    } else if (type == "switch-submini") {
        cylinder(d = 4.9, h = 10, $fn = 100);
    } else {
        cylinder(d = 6.8, h = 10, $fn = 100);
    }
}

module buttonBaseHole(type = "default", socketHoles = false) {
    if (type == "button-adafruit-1009") {
       translate([0, 0, -5]) cylinder(d = 13.1, h = 10, $fn = 100);
       cube(size = [14, 11.9, 16], center = true);
    } else if (type == "button-adafruit-1119") {
       cube(size = [14, 11.9, 7], center = true);
    } else if (type == "switch-submini") {
        translate([0, 0, -7]) cylinder(d = 4.9, h = 10, $fn = 100);
    } else {
        translate([0, 0, -7]) cylinder(d = 6.8, h = 10, $fn = 100);
    }

    if (socketHoles == true) {
       translate([0, 4.5, -5]) cylinder(d = 1.5, h = 30, $fn = 100);
       translate([0, -4.5, -5]) cylinder(d = 1.5, h = 30, $fn = 100);
    }
}

module buttonBasePocket(type = "default") {
    if (type == "button-adafruit-1009") {
        translate([0, 0, 6.5]) cube(size = [12, 16, 9], center = true);
    } else if (type == "button-adafruit-1119") {
        translate([0, 0, 4]) cube(size = [12, 16, 4], center = true);
    } else {
        // no pocket at all
    }

}