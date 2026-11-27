// Lowboard: 3 compartments side by side with 3 drawers each.
// All logic (layout, model, parts list) comes from cupboard-library.scad,
// only the differing parameters are overridden here.
include <cupboard-library.scad>

width = 1400;
depth = 790;
height = 500;
wheelHeight = 0; // no wheels; enter wheel height if needed (height includes wheels)

compartments = 3;
// A heavy laser (1140 mm wide) sits on top, flush with the right edge. The left
// face of the first divider lies exactly under the laser's left edge, so the
// divider carries the load. The two right compartments share the remaining width.
// (The laser width is written inline: a new variable defined here would not yet
// exist where compartmentWidths is first assigned in the library.)
compartmentWidths = [width - 1140 - thickness, undef, undef];
smallDrawers = 3;
largeDrawers = 0;
// Drawers per compartment: true = default layout (smallDrawers / largeDrawers),
// false = no drawers
compartmentDrawers = [false, true, true];
// Compartments without drawers get a door (double door above doorMaxWidth)
hasDoor = true;

drawerEnclosed = true;

cupboard();
partsList();
