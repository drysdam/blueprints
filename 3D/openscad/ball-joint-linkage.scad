// rod_length is measured from center of the ball to end of the stick.
module ball(ball_width, rod_width=0, rod_length=0) {
	sphere(r=ball_width/2.0, center=true);
 	cylinder(r=rod_width/2.0,h=rod_length);
}

// ball_width is the width of a ball that will fit this socket, so the
// actual width of the socket is a little larger than that. 
// rod_length is measured from the center of the ball to the end of
// the stick.
module socket(ball_width, rod_width=0, rod_length=0) {
	intersection() {
		translate([0,0,-5]) {
			difference() {
				cylinder(r=8,h=15);
				translate([-4,-9,-1]) {
					cube([8,18,12]);
				}
				translate([0,0,5]) {
					ball(ball_width+.1);
				}
			}
		}
		// rounded corners
		union() {
			translate([-10,0,3]) {
				rotate([0,90,0]) {
					cylinder(r=8,h=20);
				}
			}
			translate([-8,-8,0]) {
				cube([16,16,16]);
			}
		}
	}
	// math and translate to factor in the size of the socket and meet
	// the definition of "rod length" in the spec above.
	translate([0,0,10])	cylinder(r=rod_width/2.0,h=rod_length-10);
}

// double-ended ball piece
module ball2(ball_width1, ball_width2, rod_width, rod_length) {
	ball(ball_width1, rod_width, rod_length);
	translate([0,0,rod_length]) sphere(ball_width2/2.0);
}

// double-ended socket piece
module socket2(ball_width1, ball_width2, rod_width, rod_length) {
	socket(ball_width1, rod_width, rod_length-10);
	translate([0,0,rod_length]) rotate([180,0,0]) socket(ball_width2);
}

// socket on first end, ball on the other
module socketball(ball_width1, ball_width2, rod_width, rod_length) {
	socket(ball_width1, rod_width, rod_length);
	translate([0,0,rod_length]) sphere(ball_width2/2.0);
}

// demo
$fn=50;

// rotate([0,0,0]) ball(10, 3, 20);
// rotate([0,180,0]) socket(10, 3, 20);
// ball2(10, 5, 3, 30);
// socket2(10, 5, 3, 30);
socketball(10, 5, 3, 30);