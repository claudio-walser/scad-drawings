// type = default | tactile | adafruit

module coverHole(type = "default") {
    if (type == "adafruit") {
        cylinder(d = 11.6, h = 10, $fn = 100);
    } else if (type == "tactile") {
        cylinder(d = 6.8, h = 10, $fn = 100);
    } else {
        cylinder(d = 6.8, h = 10, $fn = 100);
    }
}

module baseHole(type = "default", socketHoles = false) {
    if (type == "adafruit") {
       translate([0, 0, -4]) cylinder(d = 12.9, h = 10, $fn = 100);
       cube(size = [14, 11.9, 16], center = true);
    } else if (type == "tactile") {
       cube(size = [14, 11.9, 7], center = true);
    } else {
        translate([0, 0, -8]) cylinder(d = 6.8, h = 10, $fn = 100);
    }

    if (socketHoles == true) {
       translate([0, 4.5, -13]) cylinder(d = 1.5, h = 10, $fn = 100);
       translate([0, -4.5, -13]) cylinder(d = 1.5, h = 10, $fn = 100);
    }
}

module basePocket(type = "default") {
    if (type == "adafruit") {
        cube(size = [12, 16, 9], center = true);
    } else if (type == "tactile") {
        translate([0, 0, 2.5]) cube(size = [12, 16, 4], center = true);
    } else {
        // no pocket at all
    }

}


// small test modules to print
module testCoverPlate(type = "default") {
    difference() {
        cube(size = [40, 40, 1], center = true);
        translate([0, 0, -8]) coverHole(type);
    }
}

module testBase(type = "default") {
    difference() {
        union() {        
            cube(size = [40, 40, 2], center = true);
            translate([0, 0, -5.5]) basePocket(type);
        }
        baseHole(type, socketHoles = true);
    }    
}



baseY = 60;
baseX = 60;


typeAda = "adafruit";
testCoverPlate(typeAda);
translate([0, baseY,  0]) !testBase(type = typeAda);

typeTact = "tactile";
translate([baseX, 0, 0]) testCoverPlate(type = typeTact);
translate([baseX, baseY, 0]) testBase(type = typeTact);

typeDef = "default";

// base plate default tactile button
// base plate default button
translate([baseX * 2, 0, 0]) testCoverPlate(type = typeDef);
translate([baseX * 2, baseY, 0]) testBase(type = typeDef);
