module edge(){
	w=10;
	hull() {
		cube([w-1,1,2],center=true);
		cube([w-1,2,1],center=true);
		cube([w,1,1],center=true);
	}
}

module face(){
	translate([0,0,-4]) edge();
	translate([4,0,0]) rotate([0,90,0]) edge();
	translate([-4,0,0]) rotate([0,90,0]) edge();
	translate([0,0,4]) edge();
}

module hyperface(w=10){
	translate([0,-4,0]) face();
	translate([0,4,0]) face();
	translate([-4,0,0]) rotate([0,0,90]) face();
	translate([4,0,0]) rotate([0,0,90]) face();
}

color("gray") 
union() {
	translate([8,0,0]) rotate([90,0,0]) face();
	translate([0,-8,0]) rotate([90,0,0]) face();
	translate([0,8,0]) rotate([90,0,0]) face();
	translate([-8,0,0]) rotate([90,0,0]) face();
	translate([-16,0,0]) rotate([90,0,0]) face();
	translate([0,0,4]) hyperface();
	translate([0,0,14]) hyperface();
	translate([0,0,24]) hyperface();
	translate([10,0,14]) hyperface();
	translate([-10,0,14]) hyperface();
	translate([0,-10,14]) hyperface();
	translate([0,10,14]) hyperface();
}