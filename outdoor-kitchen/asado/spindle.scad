include <./config.scad>

module spindle() {
    rotate([0, 90, 0]) {
        
        // Spindel
        cylinder(d = spindleDiameter, h = outerWidth - fireBasketWidth - (profileSize * 2) + spindleWallExtension + 20, $fn = 100);
        
        // Rad
        cylinder(h=20, r=spindleWheelDiameter, $fn = 100);

        // Aretiermutter
        translate([0, 0, 20])
        cylinder(h=20, r=spindleDiameter * 2, $fn = 8);
    }
}
