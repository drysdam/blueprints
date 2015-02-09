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

$fn=100;

// almost all of my gears
// ---------------------------------------------------
// pressure angle
PA=20;
// ---------------------------------------------------



// most of my gears
// ---------------------------------------------------
// diametral pitch
DP=20;
// ---------------------------------------------------



// individual gears independent data
// ---------------------------------------------------
// pitch circle diameter
PCD=1;
// ---------------------------------------------------



// combinations of the above and converted to imperial units rather than numbers
// ---------------------------------------------------
// addendum (amount of tooth above the PCD, so PCD+2*addendum = gear
// blank size)
addendum=1/DP;
dedendum=1.25/DP;
// number of gear teeth
N=DP*PCD;
// base circle calculation
basediameter=PCD*cos(PA)*25.4;
blankdiameter = (PCD + 2*addendum)*25.4;
rootdiameter = (PCD - 2*dedendum)*25.4;
// ---------------------------------------------------

pitchrot = .86;
halftoothsize = 360/(4*N);
union() {
	// dedendum circle
	cylinder(r=rootdiameter/2,h=5);
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