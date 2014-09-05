r=1;
pi=3.14159265;
intersection() {
	translate([10,0,0]) {
		linear_extrude(h=10) {
			for(theta=[0:1:89]) {
				assign(theta2=theta+1) {
					polygon(points=[[0,0], 
							[-r*(theta*sin(theta)+cos(theta)), r*(sin(theta)-theta*cos(theta))],
							[-r*(theta2*sin(theta2)+cos(theta2)), r*(sin(theta2)-theta2*cos(theta2))],
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
							[r*(theta*sin(theta)+cos(theta)), r*(sin(theta)-theta*cos(theta))],
							[r*(theta2*sin(theta2)+cos(theta2)), r*(sin(theta2)-theta2*cos(theta2))],
						],
						paths=[[0,1,2]]);
				}
			}
		}
	}
}