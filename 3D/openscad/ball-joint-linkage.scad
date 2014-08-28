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
	socketwth = 1.5*ball_width;
	socketht = 1.75*ball_width;
	notchwth = .75*ball_width;
	extranotchdepth=ball_width/1.9;
	roundradius=ball_width/2.0*1.1;
	bodyblocklength = (rod_length < socketht)?socketwth*2.0:rod_length;
	render()
	intersection() {
		difference() {
			union () {
				cylinder(r=socketwth/2.0, h=socketht, center=true);
				// put the rod in now and there's no need for any math
				// to add up the lengths
				cylinder(r=rod_width/2.0,h=rod_length);
			}
			translate([0,0,-50+extranotchdepth]) cube([notchwth,100,100], center=true);
			ball(ball_width+.1);
		}
		// rounded corners
		union() {
			rotate([0,90,0]) {
				cylinder(r=roundradius, h=socketwth+.1, center=true);
			}
			translate([0,0,(bodyblocklength+roundradius)*.95]) {
				cube([2*socketwth,2*socketwth,2*bodyblocklength], center=true);
			}
		}
    }
}

// double-ended ball piece
module ball2(ball_width1, ball_width2, rod_width, rod_length) {
	ball(ball_width1, rod_width, rod_length);
	translate([0,0,rod_length]) sphere(ball_width2/2.0);
}

// double-ended socket piece
module socket2(ball_width1, ball_width2, rod_width, rod_length) {
	socket(ball_width1, rod_width, rod_length/2.0+.1);
	translate([0,0,rod_length]) rotate([180,0,0]) socket(ball_width2, rod_width, rod_length/2.0);
}

// socket on first end, ball on the other
module socketball(ball_width1, ball_width2, rod_width, rod_length) {
	socket(ball_width1, rod_width, rod_length);
	translate([0,0,rod_length]) sphere(ball_width2/2.0);
}

// demo
// $fn=50;

// rotate([0,0,0]) ball(10, 3, 20);
//rotate([0,180,0]) socket(10, 3, 20);
// translate([30,0,0]) socket(5, 3, 30);
// translate([15,0,0]) socket(10, 3, 30);
// translate([-50,0,0]) socket(20, 3, 30);
// translate([0,0,0]) cylinder(r=3,h=30);
// ball2(10, 5, 3, 30);
// socket2(10, 10, 3, 30);
// translate([20,0,0]) cylinder(r=3,h=30);
// socketball(10, 5, 3, 30);