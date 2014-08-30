RAD=5;

module line(length) {
	cylinder(r=RAD, h=length);
	sphere(r=RAD);
	translate([0,0,length]) sphere(r=RAD);
}

module arcsegment(arcradius, degrees) {
	stepsize=10;
	bigrad=arcradius*2;
	steps=floor(degrees/stepsize);
	for(i=[1:1:steps]) {
		translate([0,0,-7]) {
			linear_extrude(height=15) {
				polygon(points=[
						[0,0], 
						[bigrad*sin((i-1)*stepsize),
							bigrad*cos((i-1)*stepsize)], 
						[bigrad*sin(i*stepsize+.1), 
							bigrad*cos(i*stepsize+.1)]], 
					paths=[[0,2,1]]);
			}
		}
	}
	translate([0,0,-7]) {
		linear_extrude(height=15) {
			polygon(points=[
					[0,0], 
					[bigrad*sin(steps*stepsize),
						bigrad*cos(steps*stepsize)], 
					[bigrad*sin(degrees), 
						bigrad*cos(degrees)]], 
				paths=[[0,2,1]]);
		}
	}
}

module arctube(arcradius, degrees) {
	render() {
		difference() {
			rotate_extrude(convexity=4) {
				translate([arcradius,0,0]) {
					circle(5);
				}
			}
			arcsegment(arcradius, 360-degrees);
		}
	}
}

module halfcircle(stublength=0) {
	union() {
		arctube(20,180);
		translate([0,20,0]) {
			rotate([0,90,0]) {
				cylinder(r=5,h=stublength);
			}
		}
		translate([0,-20,0]) {
			rotate([0,90,0]) {
				cylinder(r=5,h=stublength);
			}
		}
	}
}

module d() {
	rotate([90,0,0]) {
 		cylinder(r=5,h=80);
	}
	translate([-10,-25,0]) {
		halfcircle(10);
	}
}

module p() {
	translate([0,-50,0]) {
		rotate([0,0,180]) {
			d();
		}
	}
}

module r() {
	rotate([90,0,0]) {
 		cylinder(r=5,h=50);
	}
	translate([20,-25,0]) {
		rotate([0,0,90]) {
			arctube(20,120);
		}
	}
}

module zero() {
	// TODO: make an ellipse function so scale doesn't ruin line
	// thickness. better yet, control line thickness so can have thing
	// parts on top and bottom, like "real" letters/numbers
	scale([.75,1,1]) arctube(25,360);
}

module one() {
	rotate([90,0,0]) translate([0,0,-25]) line(50);
}

// spacing will never be right here...
module write(letters) {
	for (letter = letters) {
		if (letter == "d") d();
		if (letter == "p") p();
	}
}

module dpr() {
	d();
	translate([15,0,0]) {
		p();
	}
	translate([58,0,0]) {
		r();
	}
}

//dpr();
//one();
translate([-60,0,0]) zero();
translate([-30,0,0]) one();