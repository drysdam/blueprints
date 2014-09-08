module plain_head() {
	hull() {
		translate([0,0,20]) {
			scale([1,1,.75]) {
				sphere(20);
			}
		}
		scale([1,1,.5]) {
			sphere(20);
		}
	}
}

module eye_form() {
 	scale([1,1,1.5]) sphere(2);
}

module mouth_form() {
	scale([.1,.8,.5]) {
		difference() {
			sphere(8);
			translate([0,0,5]) cube([20,20,8], center=true);
		}
	}
}

module ear() {
	difference() {
		cylinder(r1=5,r2=0,h=15);
		translate([3,0,0]) rotate([0,15,0]) translate([0,0,-15]) cylinder(r=6,h=30);
}
}

module leg() {
	rotate([30,0,0]) {
		cylinder(r=4,h=15);
		sphere(4);
	}
}

module tail() {
	sphere(r=3);
}

$fn=50;
c="brown";
color(c)
difference() {
	plain_head();
	translate([18,-9,18]) {
		eye_form();
	}
	translate([18,9,18]) {
		eye_form();
	}
 	translate([20,0,14]) {
		mouth_form();
 	}
}
color(c) rotate([20,0,0]) translate([10,0,30]) ear();
color(c) rotate([-20,0,0]) translate([10,0,30]) ear();
color(c) translate([-20,0,0]) tail();
offset=45;
legs=4;
for(leg=[1:legs]) {
	color(c) rotate([0,0,leg*360/legs+offset]) translate([0,20,-20]) leg();
}
//plain_head();
// eye();
//mouth_form();
// rotate([0,0,0]) translate([0,20,-20]) leg();
// rotate([0,0,120]) translate([0,20,-20]) leg();
// rotate([0,0,240]) translate([0,20,-20]) leg();