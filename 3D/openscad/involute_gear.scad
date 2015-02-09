module involute(basediameter) {
	// echo(basediameter);
	// echo(-basediameter*(0*sin(0)+cos(0)), 
	// 	basediameter*(sin(0)-0*cos(0)));
	// echo(-basediameter*(.017*sin(1)+cos(1)), 
	// 	basediameter*(sin(1)-.017*cos(1)));
	// echo(-basediameter*(.034*sin(2)+cos(2)), 
	// 	basediameter*(sin(2)-.034*cos(2)));
	// echo(-basediameter*(.051*sin(3)+cos(3)), 
	// 	basediameter*(sin(3)-.051*cos(3)));
//	polygon(points=[[0,0], [-71, 0], [-71, .03], [-71, .065], [-71,.1]], paths=[[0,1,2]]);
	// polygon(points=[[0,0], 
	// 		[-basediameter*(0*sin(0)+cos(0)), 
	// 			basediameter*(sin(0)-0*cos(0))],
	// 		[-basediameter*(.017*sin(1)+cos(1)), 
	// 			basediameter*(sin(1)-.017*cos(1))],
	// 	],
	// 	paths=[[0,1,2]]);
	pi=3.1415926;
	for(thetadeg=[0:1:40]) {
		assign(thetadeg2=thetadeg+1, thetarad=thetadeg*pi/180.0, thetarad2=(thetadeg+1)*pi/180.0) {
			polygon(points=[[0,0], 
					[-basediameter*(thetarad*sin(thetadeg)+cos(thetadeg)), 
						basediameter*(sin(thetadeg)-thetarad*cos(thetadeg))],
					[-basediameter*(thetarad2*sin(thetadeg2)+cos(thetadeg2)), 
						basediameter*(sin(thetadeg2)-thetarad2*cos(thetadeg2))],
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
// addendum (amount of tooth above the PCD, so PCD+2*addendum = gear
// blank size)
addendum=1/DP;
dedendum=1.25/DP;
// ---------------------------------------------------



// individual gears independent data
// ---------------------------------------------------
// pitch circle diameter
PCD=1;
// ---------------------------------------------------



// combinations of the above and converted to imperial units rather than numbers
// ---------------------------------------------------
// base circle calculation
N=DP*PCD;
basediameter=PCD*cos(PA)*25.4;
blankdiameter = (PCD + 2*addendum)*25.4;
rootdiameter = (PCD - 2*dedendum)*25.4;
// ---------------------------------------------------


// cylinder(r=rootdiameter, h=10);
// cylinder(r=blankdiameter, h=5);
// color("red") {
// 	translate([0,0,5]) {
// 		for(toothrot=[0:360/N:360]) {
// 			rotate([0,0,toothrot]) {
// 				linear_extrude(height=4) {
// 					involute(basediameter);
// 				}
// 			}
// 		}
// 	}
// }
// color("blue") {
// 	translate([0,0,5]) {
// 		for(toothrot=[0:360/N:360]) {
// 			rotate([0,0,toothrot-360/(2*N)]) {
// 				linear_extrude(height=4) {
// 					mirror([0,1,0]) involute(basediameter);
// 				}
// 			}
// 		}
// 	}
// }
intersection() {
	cylinder(r=blankdiameter,h=5);
	linear_extrude(height=4) {
		rotate([0,0,-360/40]) mirror([0,1,0]) involute(basediameter);
		involute(basediameter);
	}
}