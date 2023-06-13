include <../library/screws.scad>

module profile(length = 10) {
    a = 8.1;
    b = 2.7;
    c = b;
    d = 4;
    e = 2.7;
    g = a;
    f = (c+a+c-g)/2;
    

    difference() {
        // stone
        translate([c+a+c, 0, 0])
        rotate([270,180,0])
        linear_extrude(length)
        polygon(
            points = [
                //x,y
                /*    a
                .  0______1
                   |    b | c
                8__9      2__3
                |            | d
                |            |
                7            4
                 \          / e
                  \        /
                   6______5
                         g   f 
                */ 


                 [c, 0], // 0
                 [c+a, 0], // 1
                 [c+a, b], // 2
                 [c+a+c, b], // 3
                 [c+a+c, b+d], // 4
                 [f+g, b+d+e], // 5
                 [f, b+d+e], // 6
                 [0, b+d], // 7
                 [0, b], // 8
                 [c, b], // 9
            ]
        );

        // screw
        translate([(c+a+c)/2, length/2, -7.5]) screwHole(6);
        translate([(c+a+c)/2, length/2, b+1]) rotate([0,0,30]) nut(11.4);
    };
}

profile(20);

