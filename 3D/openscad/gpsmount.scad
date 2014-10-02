$fn=100;
difference() {
	difference() {
		// entire thing will be just 2" wide, but don't form a cup
		// shape--let the phone be the "backplate"
		translate([0,0,.01]) cylinder(r=25.4, h=.140*25.4);
		// disk on the windshield end
		// narrow end is 1.765", wide end is 1.795" (diameters)
		cylinder(r1=1.765*25.4/2, r2=1.795*25.4/2, h=.145*25.4);
	}

	translate([0,0,.96]) difference() {
		// size of "nubs circle"
		cylinder(r=1.910*25.4/2, h=.075*25.4, center=true);
		// .750"
		translate([0,25+.750*25.4/2,0]) cube([100,50,2], center=true);
		translate([0,-25-.750*25.4/2,0]) cube([100,50,2], center=true);
		// .580"
		translate([50,25+.580*25.4/2,0]) cube([100,50,2], center=true);
		translate([50,-25-.580*25.4/2,0]) cube([100,50,2], center=true);
	}
}
