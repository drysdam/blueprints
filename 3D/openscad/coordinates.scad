module line_xyz(xyz1, xyz2, thickness, debug=false) {
	if (debug) {
		translate(xyz1) sphere(thickness);
		translate(xyz2) sphere(thickness);
	}
	xd = xyz2[0] - xyz1[0];
	yd = xyz2[1] - xyz1[1];
	zd = xyz2[2] - xyz1[2];
	length = sqrt(pow(xd,2)+pow(yd,2)+pow(zd,2));
	ang1 = acos(zd/length);
	ang2 = atan2(yd,xd);
	translate(xyz1) rotate([0,ang1,ang2]) cylinder(r=thickness, h=length);
}

line_xyz([100, 100, 100], [-100, -200, -10], 5, true);
