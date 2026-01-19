module ribbon() {
	size = 70;
	diameter = 35;
	x=size - diameter/2;
	y=diameter/2;

	hull() {
		translate([x, y, 0]) circle(d=diameter);

		alfa=asin(y / sqrt(x*x + y*y));
		xt=x * cos(2*alfa);
		yt=x * sin(2*alfa);
		polygon([[x, 0], [0,0], [xt,yt]]);
	}
}

module small_ribbon() {
	size = 60;
	diameter = 30;
	x=size - diameter/2;
	y=diameter/2;

	hull() {
		translate([x, y, 0]) circle(d=diameter);

		alfa=asin(y / sqrt(x*x + y*y));
		xt=x * cos(2*alfa);
		yt=x * sin(2*alfa);
		polygon([[x, 0], [0,0], [xt,yt]]);
	}
}


linear_extrude(3) {
	translate([90, 180, 0]) ribbon();
}

difference() {
	linear_extrude(9) {
		translate([90, 180, 0]) ribbon();
	}

	linear_extrude(9.1) {
		translate([97, 182, 0]) small_ribbon();
	}
}



rotate([0, 180, 0]) {
	translate([0, 0, -3]) linear_extrude(3) {
		translate([-90, 180, 0]) ribbon();
	}

	difference() {
		translate([0, 0, -9]) linear_extrude(9) {
			translate([-90, 180, 0]) ribbon();
		}

		translate([0, 0, -9.1]) linear_extrude(9.1) {
			translate([-83, 182, 0]) small_ribbon();
		}
	}
}

cube([180, 180, 3]);


cube([180, 4, 9]);
cube([4, 180, 9]);

translate([0, 176, 0]) cube([180, 4, 9]);
translate([176, 0, 0]) cube([4, 180, 9]);


translate([0, 176/2, 0]) cube([180, 4, 9]);
translate([176/2, 0, 0]) cube([4, 180, 9]);
