// pitch circle diameter
PCD=3;
// pressure angle
PA=20;
// base circle calculation from Gears and Gear Cutting, Ivan Law, page
// 26, figure 26
base=PCD*cos(PA);

// diametral pitch
DP=20;
// circular pitch
CP
// working depth of tooth
D=2/DP;

pi=3.14159265;
intersection() {
	translate([10,0,0]) {
		linear_extrude(h=10) {
			for(theta=[0:1:89]) {
				assign(theta2=theta+1) {
					polygon(points=[[0,0], 
							[-base*(theta*sin(theta)+cos(theta)), 
								base*(sin(theta)-theta*cos(theta))],
							[-base*(theta2*sin(theta2)+cos(theta2)), 
								base*(sin(theta2)-theta2*cos(theta2))],
						],
						paths=[[0,1,2]]);
				}
			}
		}
	}
	translate([-10,0,0]) {
		linear_extrude(h=10) {
			for(theta=[0:1:89]) {
				assign(theta2=theta+1) {
					polygon(points=[[0,0], 
							[base*(theta*sin(theta)+cos(theta)), 
								base*(sin(theta)-theta*cos(theta))],
							[base*(theta2*sin(theta2)+cos(theta2)), 
								base*(sin(theta2)-theta2*cos(theta2))],
						],
						paths=[[0,1,2]]);
				}
			}
		}
	}
}