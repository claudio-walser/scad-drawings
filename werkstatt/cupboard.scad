// Rolling cabinet with drawers.
// All logic (layout, model, parts list) comes from cupboard-library.scad.
include <cupboard-library.scad>

hasDoor = false;
largeDrawers = 1; //1:3; 2:1
smallDrawers = 3; // 5||3||1
drawerSideClearance = 12.5;
drawerTopClearance = 15;
drawerBottomClearance = 5;
drawerDepthClearance = 20;
drawerThickness = 12;

drawerEnclosed = false;

wheelHeight = 108;

frontClearance = 4;
height = 922;
width = 500;
depth = 400;
thickness = 18;

// Number of drawer compartments side by side, separated by dividers of corpus thickness
compartments = 1;

material = "MDF";
pricePerQM = 19.32;

cupboard();
partsList();
