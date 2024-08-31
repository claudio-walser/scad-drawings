include <../library/modules.scad>
include <./asado/assembly.scad>
include <./big-green-egg/large.scad>
include <./sink/sink.scad>
include <./cabinets/cabinets.scad>
include <./roaring-dragon/burner.scad>
include <../garden/pergola.scad>
include <./models/gas-bottle.scad>



firePitFrame();
rotate([0, -90, 0])
translate([0, 880, 0])
firePitMeasurementsFront();