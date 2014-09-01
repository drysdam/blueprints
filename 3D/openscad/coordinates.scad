module line_rtp(rtp1, rtp2, thickness, rounded=true) {
	// if all lines were from the origin, just doing rotates would be
	// simple. but they aren't, so convert to xyz and use line_xyz for
	// simplicity.
	r1 = rtp1[0];
	theta1 = rtp1[1];
	phi1 = rtp1[2];
	r2 = rtp2[0];
	theta2 = rtp2[1];
	phi2 = rtp2[2];
	x1 = r1*sin(theta1)*cos(phi1);
	y1 = r1*sin(theta1)*sin(phi1);
	z1 = r1*cos(theta1);
	x2 = r2*sin(theta2)*cos(phi2);
	y2 = r2*sin(theta2)*sin(phi2);
	z2 = r2*cos(theta2);
	line_xyz([x1,y1,z1], [x2,y2,z2], thickness, rounded);
}

module line_xyz(xyz1, xyz2, thickness, rounded=true) {
	if (rounded) {
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

//line_xyz([100, 100, 100], [-100, -200, -10], 5, true);
//line_rtp([100,120,0], [100,90,180], 5, true);
// line_rtp([100,0,0], [100,120,0], 5);
// line_rtp([100,120,0], [100,240,0], 5);
// line_rtp([100,240,0], [100,0,0], 5);
