include <../library/modules.scad>

// box
box(width = 310, length = 390, height = 740, wallThickness = 15, open = "front" );

// deckel
translate([-421, -122.5, 0])
    box(width = 65, length = 390, height = 740, wallThickness = 15, open = "front" );

// weinfächer
translate([0, -15, 99])
    cube(size = [390, 310, 8], center= true);
translate([0, -15, 197])
    cube(size = [390, 310, 8], center= true);

translate([-49, -15, 115])
    cube(size = [8, 310,196], center= true);


translate([4, -15, 115])
    cube(size = [8, 310,196], center= true);

















