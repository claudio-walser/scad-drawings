include <BOSL2/std.scad>
include <tray.scad>

$fn = 256;


gridSize = 50;




matrix = [
    [19,0],
    [41,0],
    [0,55],
    [60,55]
];



for (a = [ 0 : len(matrix) - 1 ]) 
{
      point=matrix[a];
      translate([point[0],point[1],0])
      {
          cylinder(r=1.4,h=10);
      }
}



innerWidth = 300;
innerDepth = 200;
innerHeight = 200;

wallThickness = 8;


//translate([innerWidth/2 + 50, 0,0])
//tray([innerWidth, innerDepth, gridSize], n_columns=3, n_rows=2, columns=[0.25, 0.75]);
//
//translate([0,0,0])
//drawerContainer(innerWidth, innerDepth, innerHeight);

//referenceBlocks();

module referenceBlocks() {
    blocksWidth = innerWidth/gridSize;
    blocksHeight = innerHeight/gridSize;
    blocksDepth = innerDepth/gridSize;
    
    for ( wcount = [0:1:blocksWidth-1] ) {
        for ( hcount = [1:1:blocksHeight] ) {
            colorValue = gridSize*hcount*wcount/1000;
            echo(colorValue)

            
            translate([innerWidth/2-gridSize/2-wcount*gridSize, 0, innerHeight/2 + gridSize/2 - hcount*gridSize])
            color([colorValue, colorValue, colorValue])cube([gridSize, gridSize, gridSize], center=true);
        }
    }
}


module drawerContainer(innerWidth, innerDepth, innerHeight) {

    difference() {
        cuboid(
            [innerWidth + 2 * wallThickness, innerDepth + wallThickness, innerHeight + 2 * wallThickness],
            chamfer=2, 
            edges=[FRONT+TOP, FRONT+RIGHT, FRONT+LEFT, FRONT+BOTTOM, BACK+TOP, BACK+RIGHT, BACK+LEFT, BACK+BOTTOM, BOTTOM+RIGHT, BOTTOM+LEFT, TOP+RIGHT, TOP+LEFT],
            $fn=24
        );

        translate([0, wallThickness, 0])
        cube([innerWidth, innerDepth , innerHeight], center=true);
    }

    amount = innerHeight/gridSize;
    for ( count = [0:1:amount-1] ) {
        if (count > 0){
            // left drawer supports
            translate([+innerWidth/2 - wallThickness/4 ,0, -innerHeight/2 + wallThickness/2 + (count*gridSize) - wallThickness - wallThickness/2])
            drawerSupport(innerDepth, LEFT);

            // right drawer supports
            translate([-innerWidth/2 + wallThickness/4 ,0, -innerHeight/2 + wallThickness/2 + (count*gridSize) - wallThickness - wallThickness/2])
            drawerSupport(innerDepth, RIGHT);
        }
    }
}



module drawerSupport(innerDepth, direction) {
    translate([0, -wallThickness/2, 0])
    cuboid([wallThickness/2, innerDepth, wallThickness*2], chamfer=wallThickness/2, edges=[BOTTOM+direction]);
}
