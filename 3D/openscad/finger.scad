include <ball-joint-linkage.scad>;

module finger(s) {
	l1 = 30;
	l2 = 20;
	l3 = 15;
	scale([s,s,s]) {
		translate([0,0,0]) rotate([0,180,0]) ball(10,3,10/s);
		socketball(10,8,3,l1);
		translate([0,0,l1]) socketball(8,6,3,l2);
		translate([0,0,l1+l2]) socketball(6,4,3,l3);
	}
}

$fn=20;
// thumb
translate([-20,0,-40]) rotate([0,-30,0]) finger(1);
// index
translate([0,0,0]) finger(1);
// middle
translate([17,0,0]) finger(1.1);
// ring
translate([34,0,0]) finger(1);
// pinky
translate([48,0,0]) finger(.75);
// palm
translate([21,0,-38]) cube([60,10,62], center=true);
translate([-10,0,-55]) rotate([0,-30,0]) cube([10,10,24], center=true);
