include <../library/tnut.scad>




// Examples
//tnut(40, holes=4, spacing=10); // 4-hole 40mm

//tnut(40, holes=2, spacing=20); // 2-hole 40mm
//xmove(20) tnut(10); // 1-hole 20mm

//xmove(20) tnut(10); // 1-hole 10mm

//xmove(40) tnut(40, holes=3, spacing=10, base=3); // 3-holes 10mm apart with a 3mm base

// square nut with 6mm diagonal
//xmove(-20) tnut(20, holes=2, spacing=10, nutsides=4, nutrotation=45, nutsize=6);

// Customizer
tnut(40);
