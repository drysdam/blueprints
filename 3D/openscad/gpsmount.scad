$fn=100;
difference() {
	difference() {
		translate([0,0,-1.3]) cylinder(r=50.8, h=5);
		// disk on the windshield end
		cylinder(r2=45.6, r1=44.7, h=3.8);
	}


	translate([0,0,1]) difference() {
		cylinder(r=48.51, h=1.9, center=true);
		// .750"
		translate([0,25+19.1,0]) cube([100,50,2], center=true);
		translate([0,-25-19.1,0]) cube([100,50,2], center=true);
		// .580"
		translate([50,25+14.7,0]) cube([100,50,2], center=true);
		translate([50,-25-14.7,0]) cube([100,50,2], center=true);
	}
}
