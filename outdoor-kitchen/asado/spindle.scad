include <./config.scad>
include <./spindleGear.scad>
include <./spindleHandle.scad>
module spindle() {

    spindleLength = outerWidth - fireBasketWidth - (profileSize * 2) + spindleWallExtension + (spindleOverlength * 2);
    // short length for prototype printing
    // spindleLength = 40;

    module partsList() {
        // Spindel
        echo(str("30;Spindel - Rundstahl;1;", spindleLength, ";", spindleDiameter, ";", spindleDiameter));
    }

    // Spindel
    difference() {
        cylinder(d = spindleDiameter, h = spindleLength);
        translate([spindleDiameter * 0.75, 0, 0]) translate([-spindleDiameter/2, -spindleDiameter/2, -1]) cube([spindleDiameter, spindleDiameter, spindleHandleThickness]);

        translate([0, 0, -10]) cylinder(d= 3.5, h = 40);
    }

    translate([0, 0, spindleDiameter + 12])
    spindleGear();

    partsList();
}
