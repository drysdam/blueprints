// sizes are defined as thousandths of an inch, so scale by .0254 to
// print in mm
include <alphanumeric.scad>;

$fn=50;

module sharp_corner_ring() {
	difference() {
		// ring
		difference() {
			cylinder(r=750/2,h=60);
			translate([0,0,-100]) {
				cylinder(r=650/2,h=200);
			}
		}
		// gap
		translate([200,0,0]) {
			cube([400,220,200],center=true);
		}
	}
	translate([330,120,0]) {
		cylinder(r=30,h=60);
	}
	translate([330,-120,0]) {
		cylinder(r=30,h=60);
	}
}

module base_ring() {
	intersection() {
		sharp_corner_ring();
	}
}

// dpr/knvr ring
scale(.0254) {
	base_ring();
	difference() {
		scale([1,1,4]) translate([0,0,7.5]) rotate([0,0,113.5]) {
			arcsegment(550, 45);
		}
		scale([1,1,6]) translate([0,0,5]) rotate([0,0,120]) {
			arcsegment(325, 60);
		}
	}
	translate([-400,70,3]) rotate([0,0,-90]) scale(1.5) {
		dpr();
	}
	// translate([-390,75,3]) rotate([0,0,-90]) {
	// 	knvr();
	// }
}
