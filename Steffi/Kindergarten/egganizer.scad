use <MCAD/regular_shapes.scad>
use <dotSCAD/golden_spiral.scad>
use <dotSCAD/archimedean_spiral.scad>
use <dotSCAD/polyline2d.scad>
use <dotSCAD/maze/mz_square.scad>
use <dotSCAD/line2d.scad>



// level of detail
$fn = 120;

eggHeight = 180;
eggWidth = 130;
thickness = 4;
innerHeight = 5;


module eggCutter() {

		translate([0, 0, -10])
		difference() {
			cylinder(h=innerHeight+thickness+20,r=1000);
			linear_extrude(height=innerHeight+thickness+20) egg_outline(eggWidth, eggHeight);
		};

}

module egg() {
	// Egg Floor
	linear_extrude(height=thickness)
	egg_outline(eggWidth, eggHeight);

	// Egg Frame
	linear_extrude(height=innerHeight+thickness)
	difference() {
		egg_outline(eggWidth, eggHeight);
		translate([0, thickness, 0]) egg_outline(eggWidth - thickness * 2, eggHeight - thickness * 2);
	}
}


module eggInlineEggs() {
	// Egg inlines
	step = 0.2;
	moveUp = 17;
	for ( i = [1 : 5] ) {
		scaleFactor = step * i;
		translateY = moveUp * (5-i);

		echo(str(scaleFactor));
		echo(str(translateY));

		linear_extrude(height=innerHeight+thickness)
		translate([0, translateY, 0])
		scale([scaleFactor, scaleFactor])
		difference() {
			egg_outline(eggWidth, eggHeight);
			translate([0, thickness/scaleFactor, 0]) egg_outline(eggWidth - (thickness * 2) / scaleFactor, eggHeight - (thickness * 2) / scaleFactor);
		}
	}
}

module eggInlineBigEggs() {
	eggScale = 3;
	bigEggWidth = eggWidth * eggScale;
	bigEggHeight = eggHeight * eggScale;
	moveUp = 20;


	difference(){
		rotate([0, 0, 45])
		translate([0, -23, 0])
		for ( i = [1 : 6] ) {

			translateY = moveUp * i;
			translate([0, translateY, 0])
			linear_extrude(height=innerHeight+thickness)
			difference() {
				egg_outline(bigEggWidth, bigEggHeight);
				translate([0, thickness, 0]) egg_outline(bigEggWidth - thickness * 2, bigEggHeight - thickness * 2);
			}
		};

		eggCutter();
	}
}

module eggInlineFiboneggi() {
	// phi = (1 + sqrt(5)) / 2; // =~ 1.618

	// function radius(angle) = 10 * pow(phi, (angle / 90));

	// linear_extrude(10)
	// scale(0.3, 0.3)
	// for(i = [0:1:720]) {
	//     translate([sin(i) * radius(i), cos(i) * radius(i)]) circle(3);
	// }
	translate([-10, 70, 0])
	rotate([0, 0, 180])

	linear_extrude(height=innerHeight+thickness)
	scale([6, 6]) {
		pts_angles = golden_spiral(
		    from = 1,
		    to = 7,
		    point_distance = 0.02
		);

		for(pt_angle = pts_angles) {
		    translate(pt_angle[0])
		        circle(0.2);
		}
	}
}

module eggInlineSpiral() {

	translate([0, 94.5, 0])
	scale([1, 1.7])
	linear_extrude(height=innerHeight+thickness) {
		points_angles = archimedean_spiral(
		    arm_distance = 15,
		    init_angle = 180,
		    point_distance = 0.1,
		    num_of_points = 5000
		);

		for(pa = points_angles) {
		    translate(pa[0])
		        circle(1);
		}
	}
}

module eggInlineMaze() {
	rows = 10;
	columns = 10;
	cell_width = 20;
	wall_thickness = 4;

	NO_WALL = 0;
	TOP_WALL = 1;
	RIGHT_WALL = 2;
	TOP_RIGHT_WALL = 3;
	MASK = 4;

	cells = mz_square(rows, columns);
	difference() {
		linear_extrude(height=innerHeight+thickness) translate([-eggWidth/2, 0, 0]) union() {
			for(row = cells, cell = row) {
			    type = cell[2];

			    translate([cell.x, cell.y] * cell_width) {
			        if(type == TOP_WALL || type == TOP_RIGHT_WALL) {
			            line2d([0, cell_width], [cell_width, cell_width], wall_thickness);
			        }

			        if(type == RIGHT_WALL || type == TOP_RIGHT_WALL) {
			            line2d([cell_width, cell_width], [cell_width, 0], wall_thickness);
			        }
			    }
			}
			line2d([0, 0], [cell_width * columns, 0], wall_thickness);
			line2d([0, 0], [0, cell_width * rows], wall_thickness);
		}

		eggCutter();
	}
}

egg();
// eggInlineEggs();
// eggInlineBigEggs();
// eggInlineFiboneggi();
// eggInlineSpiral();
eggInlineMaze();




// use <dotSCAD/noise/nz_cell.scad>
// use <dotSCAD/golden_spiral.scad>
// use <dotSCAD/surface/sf_thicken.scad>
// use <dotSCAD/ptf/ptf_rotate.scad>

// size = [150, 150];
// thickness = 5;
// height_factor = 0.7;
// pixel_step = 0.75;
// spirals = 1;
// spiral_from = 5;
// spiral_to = 10;
// spiral_pt_dist = 10;


// half_size = size / 2;
// half_pixel_step = pixel_step / 2;
// pts_angles = golden_spiral(
//     from = spiral_from,
//     to = spiral_pt_dist,
//     point_distance = spiral_pt_dist
// );

// a_step = 360 / spirals;
// cells = [
//     for(i = [0:spirals - 1], pt_angle = pts_angles)
//         ptf_rotate(pt_angle[0], i * a_step)
// ];
// noised = [
//     for(y = [-half_size[1]:pixel_step:half_size[1]])
//     [
//         for(x = [-half_size[0]:pixel_step:half_size[0]])
//         let(n = nz_cell(cells, [x, y] * height_factor) )
//             [x, y, n < half_pixel_step ? half_pixel_step : n]
//     ]
// ];

// sf_thicken(noised, thickness);