module ball() {
	sphere(r=5);
}

module socket() {
	intersection() {
		translate([0,0,-5]) {
			difference() {
				cylinder(r=8,h=15);
				translate([-4,-9,-1]) {
					cube([8,18,12]);
				}
				translate([0,0,5]) {
					ball();
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
}

$fn=100;

// ball();
// rotate([180,0,0]) {
// 	cylinder(r=2,h=20);
// }

socket();
translate([0,0,7]) {
	cylinder(r=2,h=20);
}