include <alphanumeric.scad>;

$fn=20;

module sharp_corner_ring() {
	difference() {
		// ring
		difference() {
			cylinder(r=750/2,h=60);
			translate([0,0,-100]) {
				cylinder(r=700/2,h=200);
			}
		}
		// gap
		translate([200,0,0]) {
			cube([400,420,200],center=true);
		}
	}
}

module corner_rounder() {
	translate([275,230,-10]) {
		cylinder(r=20,h=200);
	}
	translate([275,-230,-10]) {
		cylinder(r=20,h=200);
	}
	translate([-100,0,0]) cube([730,800,200], center=true);
	translate([265,250,0]) cube([50,50,200], center=true);
	translate([265,-250,0]) cube([50,50,200], center=true);
}

module base_ring() {
	intersection() {
		sharp_corner_ring();
		corner_rounder();
	}
}

// dpr ring
base_ring();
difference() {
	scale([1,1,4]) translate([0,0,7.5]) rotate([0,0,105]) arcsegment(500, 30);
	translate([-400,30,3]) rotate([0,0,-90]) dpr();
	scale([1,1,6]) translate([0,0,7]) rotate([0,0,106]) arcsegment(350, 32);
}