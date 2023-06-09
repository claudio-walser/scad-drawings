include <../library/modules.scad>



width = 1.400;
height = 1.400;
depth = 0.400;
thickness = 0.025;


// lower board
boardMitreJoints(width, depth, thickness);
// top board
translate([0, depth, height]) rotate([180, 0, 0]) boardMitreJoints(width, depth, thickness);
// left board
translate([0, 0, height]) rotate([0, 90, 0]) boardMitreJoints(width, depth, thickness);

translate([width, 0, 0]) rotate([0, -90, 0]) boardMitreJoints(width, depth, thickness);



module partsList() {
    // Beine Hinten
    echo(str("Nussbaum Bretter unten/oben", " ", "2", " ", width, " ", depth, " ", thickness));
    echo(str("Nussbaum Bretter seitlich", " ", "2", " ", height, " ", depth, " ", thickness));
}

partsList();