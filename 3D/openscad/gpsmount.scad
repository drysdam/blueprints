$fn=100;
difference() {
	// I would prefer to have a solid backing plate, but that would be
	// impossible to print without supports on a single-nozzle
	// printer. instead, make just a ring with no plate (the little
	// .01/.02 stuff is to get a clean diff().
	translate([0,0,.01]) cylinder(r=2*25.4/2, h=.145*25.4-.02);
	// disk on the windshield end
	// narrow end is 1.765", wide end is 1.795" (diameters)
	cylinder(r1=1.765*25.4/2, r2=1.795*25.4/2, h=.145*25.4);
	// nubs
	difference() {
		cylinder(r=1.910*25.4/2, h=.075*25.4);
		// .750"
		translate([0,25+.750*25.4/2,0]) cube([100,50,5], center=true);
		translate([0,-25-.750*25.4/2,0]) cube([100,50,5], center=true);
		// .580"
		translate([50,25+.580*25.4/2,0]) cube([100,50,5], center=true);
		translate([50,-25-.580*25.4/2,0]) cube([100,50,5], center=true);
	}
}