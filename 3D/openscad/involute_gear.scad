module involute(basediameter) {
	pi=3.1415926;
	for(thetadeg=[0:1:89]) {
		assign(thetadeg2=thetadeg+1, thetarad=thetadeg*pi/180.0, thetarad2=(thetadeg+1)*pi/180.0) {
			polygon(points=[[0,0], 
					[-basediameter/2*(thetarad*sin(thetadeg)+cos(thetadeg)), 
						basediameter/2*(sin(thetadeg)-thetarad*cos(thetadeg))],
					[-basediameter/2*(thetarad2*sin(thetadeg2)+cos(thetadeg2)), 
						basediameter/2*(sin(thetadeg2)-thetarad2*cos(thetadeg2))],
				],
				paths=[[0,1,2]]);
		}
	}
}

// unless I'm doing something crazy, PA is 20.
// I might do DP as something else, but for a whole bunch of
// individual gears
// N will vary by gear.
module gear(N, DP=20, PA=20) {
	// combinations of the above and converted to imperial units rather than numbers
	// ---------------------------------------------------
	// addendum (amount of tooth above the PCD, so PCD+2*addendum = gear
	// blank size)
	addendum=1/DP;
	dedendum=1.25/DP;
	// pitch circle diameter
	PCD = N/DP;
	// base circle calculation
	basediameter=PCD*cos(PA)*25.4;
	blankdiameter = (PCD + 2*addendum)*25.4;
	rootdiameter = (PCD - 2*dedendum)*25.4;
	// ---------------------------------------------------

	// this number empirically derived and appears to be a
	// constant. sqrt(3)/2?
	pitchrot = .86;
	halftoothsize = 360/(4*N);
	union() {
		// dedendum circle
		cylinder(r=rootdiameter/2,h=4);
		intersection() {
			// addendum circle
			cylinder(r=blankdiameter/2,h=5);
			for(toothrot=[0:360/N:360]) {
				rotate([0,0,toothrot]) {
					linear_extrude(height=4) {
						intersection() {
							rotate([0,0,-pitchrot-halftoothsize]) mirror([0,1,0]) involute(basediameter);
							rotate([0,0,pitchrot+halftoothsize]) involute(basediameter);
						}
					}
				}
			}
		}
	}
	// color("white") cylinder(r=blankdiameter/2, h=1);
	// color("yellow") cylinder(r=(PCD*25.4)/2, h=2);
	// cylinder(r=basediameter/2, h=3);
	// color("black") cylinder(r=rootdiameter/2, h=4);
	// pitchrot = .86;
	// toothsize = 360/(4*N);
	// color("red") linear_extrude(height=5) {
	// 	intersection() {
	// 		rotate([0,0,-pitchrot-toothsize]) mirror([0,1,0]) involute(basediameter);
	// 		rotate([0,0,pitchrot+toothsize]) involute(basediameter);
	// 	}
	// }
}

// all racks have an infinite PCD, so the only variables are DP and
// PA. that said, I would like a length variable so let's make it the
// number of teeth.
module rack(N, DP=20, PA=20) {
	pi=3.1415926;
	CP = pi/DP * 25.4;
	drawingdepth = CP/(2*tan(PA));
	pitchline = drawingdepth/2;
	addendum=1/DP * 25.4;
	dedendum=1.25/DP * 25.4;
	addendumline = (pitchline + addendum);
	dedendumline = (pitchline - dedendum);

	difference() {
        for(toothnum=[0:1:N-1]) {
			linear_extrude(height=7) {
				polygon(points=[[(toothnum)*CP,0], [(toothnum+.5)*CP,drawingdepth], [(toothnum+1)*CP,0]],
					paths=[[0,1,2]]);
			}
		}
		translate([0, addendumline, -1]) cube([N*CP,3,9]);
	}
	translate([0,-3+dedendumline, 0]) cube([N*CP,3,7]);
}

$fn=100;

// N, DP, PA
gear(22, 32, 14.5);

// with hole for shaft
// difference() {
// 	// for an N-tooth gear of a given pitch, back-calc the PD
// 	gear(22/32, 32, 14.5);
// 	translate([0,0,-1]) cylinder(r=3/32*25.4, h=10);
// }

// shafts
// scale(25.4) {
// 	cube([2,1,.125]);
// 	translate([22/32,.5,0]) cylinder(r=3/32-.005, h=.500);
// 	translate([2-22/32,.5,0]) cylinder(r=3/32-.005, h=.500);
// }

//gear(2.25, 18, 14.5);
//translate([50,0,0]) gear(1,48);
//rack(20,48);
