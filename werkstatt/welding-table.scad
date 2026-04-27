$fn = 256;

module tube(outerWidth = 40, outerHeight = 20, thickness = 3, length = 1500) {

    difference() {
        cube([length, outerWidth, outerHeight]);
        
        translate([-5, thickness, thickness])
        cube([length + 10, outerWidth - thickness * 2, outerHeight - thickness * 2]);
    }
}



for (i=[0:25]) {
   translate([0,i*70,0])
     tube(length = 1000);
}

//tube();