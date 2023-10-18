include <../library/modules.scad>

// Fläche
cube(size = [3750, 5250, 10]);

// Fundament
cube(size = [3750, 1000, 100]);
cube(size = [1000, 5250, 100]);

cube(size = [3750, 250, 1800]);
cube(size = [250, 5250, 1800]);

translate([3500, 0, 0])
cube(size = [250, 3750, 1200]);

translate([250, 0, 100])
cube(size = [800, 5250, 900]);

translate([0, 250, 100])
cube(size = [3750, 800, 900]);
