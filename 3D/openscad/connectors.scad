$fn=50;

module no_overhang_f () {
	rotate_extrude(convexity=10) {
		polygon([[0,5],[1.5,3],[1,2],[1,0],[3,0],[3,5]],[[0,1,2,3,4,5,0]]);
	}
}

module no_overhang_m () {
	difference(convexity=10) {
		rotate_extrude(convexity=10) {
			polygon([[0,5],[1.5,3],[1,2],[1,0],[0,0],[0,5]],[[0,1,2,3,4,5,0]]);
		}
		translate([0,0,3]) cube([.75,5,5], center=true);
		translate([0,2.01,0]) rotate([0,0,90]) cube([2,5,10], center=true);
		translate([0,-2.01,0]) rotate([0,0,90]) cube([2,5,10], center=true);
	}
}

// cutaway view
difference(convexity=10) {
	no_overhang_f();
	translate([0,4,0]) cube([8,8,12], center=true);
}
no_overhang_m();
