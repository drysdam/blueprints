$fn=50;

module once_no_overhang_f () {
	rotate_extrude(convexity=10) {
		polygon([[0,5],[1.5,3],[1,2],[1,0],[3,0],[3,5]],[[0,1,2,3,4,5,0]]);
	}
}

module once_no_overhang_m () {
	difference(convexity=10) {
		rotate_extrude(convexity=10) {
			polygon([[0,5],[1.5,3],[1,2],[1,0],[0,0],[0,5]],[[0,1,2,3,4,5,0]]);
		}
		translate([0,0,3]) cube([.75,5,5], center=true);
		translate([0,2.01,0]) rotate([0,0,90]) cube([2,5,10], center=true);
		translate([0,-2.01,0]) rotate([0,0,90]) cube([2,5,10], center=true);
	}
}

module many_no_overhang_f () {
	difference() {
		rotate_extrude(convexity=10) {
			polygon([[0,5],[1.5,3],[1,2],[1,0],[3,0],[3,5]],[[0,1,2,3,4,5,0]]);
		}
		cube([3,1,6], center=true);
	}
}

module many_no_overhang_m () {
	// cubes are 3 wide in x but centered, rotated 90, then translated
	// 2, which puts them .5 from the origin.  think this leaves the
	// tip 1 unit wide
	difference(convexity=10) {
		rotate_extrude(convexity=10) {
			polygon([[0,5],[1.5,3],[1,2],[1,0],[0,0],[0,5]],[[0,1,2,3,4,5,0]]);
		}
		translate([0,2,3.5]) rotate([0,0,90]) cube([3,5,3], center=true);
		translate([0,-2,3.5]) rotate([0,0,90]) cube([3,5,3], center=true);
		// knock the point off
		translate([0,0,5]) cube([1,1,1], center=true);
	}
}

// // cutaway view
// difference(convexity=10) {
// 	once_no_overhang_f();
// 	translate([0,4,0]) cube([8,8,12], center=true);
// }
// once_no_overhang_m();

// // cutaway view
// difference(convexity=10) {
// 	many_no_overhang_f();
// 	translate([0,4,0]) cube([8,8,12], center=true);
// }
// many_no_overhang_m();
