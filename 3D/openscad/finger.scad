include <ball-joint-linkage.scad>;

module finger(s) {
	l1 = 30;
	l2 = 20;
	l3 = 15;
	scale([s,s,s]) {
		socketball(10,8,3,l1);
		translate([0,0,l1]) socketball(8,6,3,l2);
		translate([0,0,l1+l2]) socketball(6,4,3,l3);
	}
}

$fn=20;
translate([0,0,0]) finger(1);
translate([17,0,0]) finger(1.1);
translate([34,0,0]) finger(1);
translate([48,0,0]) finger(.75);
