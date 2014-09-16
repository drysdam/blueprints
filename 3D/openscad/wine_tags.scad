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

translate([-75,0,0])
difference() {
	translate([-150,0,0]) cylinder(r=275,h=60);
	translate([0,0,-5]) cylinder(r=300,h=70);
}
	// difference() {
	// 	scale([1,1,4]) translate([0,0,7.5]) rotate([0,0,113.5]) {
	// 		arcsegment(550, 45);
	// 	}
	// 	scale([1,1,6]) translate([0,0,5]) rotate([0,0,120]) {
	// 		arcsegment(325, 60);
	// 	}
	// }
	// translate([-500,130,3]) scale(3.2) {
	// 	d();
	// }
	// translate([-480,130,3]) scale(3.5) {
	// 	k();
	// }
}
