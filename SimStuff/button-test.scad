include <../library/buttons.scad>



// small test modules to print
module testCoverPlate(type = "default") {
    difference() {
        cube(size = [40, 40, 1], center = true);
        translate([0, 0, -8]) buttonCoverHole(type);
    }
}

module testBase(type = "default") {
    difference() {
        union() {        
            cube(size = [40, 40, 2], center = true);
            translate([0, 0, -5.5]) buttonBasePocket(type);
        }
        buttonBaseHole(type, socketHoles = true);
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
translate([baseX * 2, 0, 0]) testCoverPlate(type = typeDef);
translate([baseX * 2, baseY, 0]) testBase(type = typeDef);
