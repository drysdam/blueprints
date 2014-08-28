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

// demo
// $fn=50;

// rotate([0,0,0]) ball(10, 3, 20);
// rotate([0,180,0]) socket(10, 3, 20);
