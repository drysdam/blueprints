module polyhedron2(points, faces, thickness, spherical=false) {
	for (face = faces) {
		for (facepos = [0:len(face)-1]) {
			if (spherical) {
				line_rtp(points[face[facepos]], 
					facepos+1>=len(face)?points[face[0]]:points[face[facepos+1]], 
					thickness, true);
			} else {
				line_xyz(points[face[facepos]], 
					facepos+1>=len(face)?points[face[0]]:points[face[facepos+1]], 
					thickness, true);
			}
		}
	}
}

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

module line_xyz(xyz1, xyz2, thickness) {
	xd = xyz2[0] - xyz1[0];
	yd = xyz2[1] - xyz1[1];
	zd = xyz2[2] - xyz1[2];
	length = sqrt(pow(xd,2)+pow(yd,2)+pow(zd,2));
	ang1 = acos(zd/length);
	ang2 = atan2(yd,xd);
	translate(xyz1) sphere(thickness);
	translate(xyz2) sphere(thickness);
	translate(xyz1) rotate([0,ang1,ang2]) cylinder(r=thickness, h=length);
}

//line_xyz([100, 100, 100], [-100, -200, -10], 5, true);
// line_xyz([-100, 100, 100], [-100, -200, 10], 5, true);
//line_xyz([100, 100, 100], [-100, -200, -10], 5, true);
//line_rtp([100,120,0], [100,90,180], 5, true);
// line_rtp([100,0,0], [100,120,0], 5);
// line_rtp([100,120,0], [100,240,0], 5);
// line_rtp([100,240,0], [100,0,0], 5);
//polyhedron2([[0,0,0],[50,50,50],[50,0,0]], [[0, 1, 2]], 3);

// renders (F6) in 2m11s
// polyhedron2([
// 		[50,0,0],[50,90,0],[50,90,90],
// 		[50,90,180],[50,90,270],[50,180,0]], 
// 	[
// 		[0, 1, 2],[0, 2, 3],
// 		[0, 3, 4],[0, 4, 1],
// 		[5, 2, 1],[5, 3, 2],
// 		[5, 4, 3],[5, 1, 4]
// 	], 3, true);

// renders in 47s
// line_rtp([50,0,0],[50,90,0],3);
// line_rtp([50,0,0],[50,90,90],3);
// line_rtp([50,0,0],[50,90,180],3);
// line_rtp([50,0,0],[50,90,270],3);
// line_rtp([50,180,0],[50,90,0],3);
// line_rtp([50,180,0],[50,90,90],3);
// line_rtp([50,180,0],[50,90,180],3);
// line_rtp([50,180,0],[50,90,270],3);
// line_rtp([50,90,0], [50,90,90],3);
// line_rtp([50,90,90], [50,90,180],3);
// line_rtp([50,90,180], [50,90,270],3);
// line_rtp([50,90,270], [50,90,0],3);

// renders in 52s
// line_xyz([0,0,50], [50,0,0], 3);
// line_xyz([0,0,50], [0,50,0], 3);
// line_xyz([0,0,50], [-50,0,0], 3);
// line_xyz([0,0,50], [0,-50,0], 3);
// line_xyz([0,0,-50], [50,0,0], 3);
// line_xyz([0,0,-50], [0,50,0], 3);
// line_xyz([0,0,-50], [-50,0,0], 3);
// line_xyz([0,0,-50], [0,-50,0], 3);
// line_xyz([50,0,0], [0,50,0], 3);
// line_xyz([0,50,0], [-50,0,0], 3);
// line_xyz([-50,0,0], [0,-50,0], 3);
// line_xyz([0,-50,0], [50,0,0], 3);
