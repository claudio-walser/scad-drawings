// Lowboard: 3 Abteile nebeneinander mit je 3 Schubladen.
// Die ganze Logik (Einteilung, Plan, Stückliste) kommt aus cupboard.scad,
// hier werden nur die Parameter überschrieben.
include <cupboard.scad>

width = 1400;
depth = 790;
height = 500;
wheelHeight = 0; // ohne Rollen; bei Bedarf Rollenhöhe eintragen (height ist inkl. Rollen)

compartments = 3;
smallDrawers = 3;
largeDrawers = 0;

drawerEnclosed = false;
