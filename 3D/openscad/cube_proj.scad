include <coordinates.scad>;



module 4Dto3D(t) {
	// 4d
	// corners = [1/2 1/2 1/2 3/2;
	// 			 1/2 1/2 1/2 1/2;
	// 			 -1/2 1/2 1/2 1/2;
	// 			 -1/2 1/2 1/2 3/2;
	// 			 1/2 -1/2 1/2 3/2;
	// 			 1/2 -1/2 1/2 1/2;
	// 			 -1/2 -1/2 1/2 1/2;
	// 			 -1/2 -1/2 1/2 3/2;
	// 			 1/2 1/2 -1/2 3/2;
	// 			 1/2 1/2 -1/2 1/2;
	// 			 -1/2 1/2 -1/2 1/2;
	// 			 -1/2 1/2 -1/2 3/2;
	// 			 1/2 -1/2 -1/2 3/2;
	// 			 1/2 -1/2 -1/2 1/2;
	// 			 -1/2 -1/2 -1/2 1/2;
	// 			 -1/2 -1/2 -1/2 3/2];
	// 3d
	//  2.00000   2.00000   2.00000
	//  0.66667   0.66667   0.66667
	// -0.66667   0.66667   0.66667
	// -2.00000   2.00000   2.00000
	//  2.00000  -2.00000   2.00000
	//  0.66667  -0.66667   0.66667
	// -0.66667  -0.66667   0.66667
	// -2.00000  -2.00000   2.00000
	//  2.00000   2.00000  -2.00000
	//  0.66667   0.66667  -0.66667
	// -0.66667   0.66667  -0.66667
	// -2.00000   2.00000  -2.00000
	//  2.00000  -2.00000  -2.00000
	//  0.66667  -0.66667  -0.66667
	// -0.66667  -0.66667  -0.66667
	// -2.00000  -2.00000  -2.00000
	$fn = 20;
	translate([-t,0,t]) scale(10) {
//		translate([0, 1.5, 1.5]) rotate([45, 0, 0]) scale([2.1,1.3,.01]) circle(1);
		polyhedron2([
				[-2/3, 2/3, 2/3],
				[ 2/3, 2/3, 2/3],
				[ 2/3,-2/3, 2/3],
				[-2/3,-2/3, 2/3],
				[-2/3, 2/3,-2/3],
				[ 2/3, 2/3,-2/3],
				[ 2/3,-2/3,-2/3],
				[-2/3,-2/3,-2/3],
				[-2, 2, 2],
				[ 2, 2, 2],
				[ 2,-2, 2],
				[-2,-2, 2],
				[-2, 2,-2],
				[ 2, 2,-2],
				[ 2,-2,-2],
				[-2,-2,-2],
			],
			[
				[0, 1],
				[1, 2],
				[2, 3],
				[3, 0],
				[4, 5],
				[5, 6],
				[6, 7],
				[7, 4],
				[0, 4],
				[1, 5],
				[2, 6],
				[3, 7],
				[8, 9],
				[9, 10],
				[10, 11],
				[11, 8],
				[12, 13],
				[13, 14],
				[14, 15],
				[15, 12],
				[8, 12],
				[9, 13],
				[10, 14],
				[11, 15],
				[0, 8],
				[1, 9],
				[2, 10],
				[3, 11],
				[4, 12],
				[5, 13],
				[6, 14],
				[7, 15],
			],
			.1);
	}
	// 4d
	// corners = [0 1/2 1/2 1+sqrt(2)/2;
	// 			 sqrt(2)/2 1/2 1/2 0;
	// 			 0 1/2 1/2 1-sqrt(2)/2;
	// 			 -sqrt(2)/2 1/2 1/2 0;
	// 			 0 -1/2 1/2 1+sqrt(2)/2;
	// 			 sqrt(2)/2 -1/2 1/2 0;
	// 			 0 -1/2 1/2 1-sqrt(2)/2;
	// 			 -sqrt(2)/2 -1/2 1/2 0;
	// 			 0 1/2 -1/2 1+sqrt(2)/2;
	// 			 sqrt(2)/2 1/2 -1/2 0;
	// 			 0 1/2 -1/2 1-sqrt(2)/2;
	// 			 -sqrt(2)/2 1/2 -1/2 0;
	// 			 0 -1/2 -1/2 1+sqrt(2)/2;
	// 			 sqrt(2)/2 -1/2 -1/2 0;
	// 			 0 -1/2 -1/2 1-sqrt(2)/2;
	// 			 -sqrt(2)/2 -1/2 -1/2 0];
	// 3d
	//  0.00000   3.41421   3.41421
	//  0.70711   0.50000   0.50000
	//  0.00000   0.58579   0.58579
	// -0.70711   0.50000   0.50000
	//  0.00000  -3.41421   3.41421
	//  0.70711  -0.50000   0.50000
	//  0.00000  -0.58579   0.58579
	// -0.70711  -0.50000   0.50000
	//  0.00000   3.41421  -3.41421
	//  0.70711   0.50000  -0.50000
	//  0.00000   0.58579  -0.58579
	// -0.70711   0.50000  -0.50000
	//  0.00000  -3.41421  -3.41421
	//  0.70711  -0.50000  -0.50000
	//  0.00000  -0.58579  -0.58579
	// -0.70711  -0.50000  -0.50000

	translate([t,0,t]) scale(10) {
		//	translate([0, -2, -2]) rotate([45, 0, 0]) scale([2*sqrt(2)/2,sqrt(6)/2,.01]) circle(1);
		polyhedron2([
				[-(2+sqrt(2)), 0, -(2+sqrt(2))],
				[+(2+sqrt(2)), 0, -(2+sqrt(2))],
				[-(2-sqrt(2)), 0, -(2-sqrt(2))],
				[+(2-sqrt(2)), 0, -(2-sqrt(2))],
				[-1/2, +sqrt(2), -1/2],
				[+1/2, +sqrt(2), -1/2],
				[-1/2, -sqrt(2), -1/2],
				[+1/2, -sqrt(2), -1/2],
				[-(2+sqrt(2)), 0, +(2+sqrt(2))],
				[+(2+sqrt(2)), 0, +(2+sqrt(2))],
				[-(2-sqrt(2)), 0, +(2-sqrt(2))],
				[+(2-sqrt(2)), 0, +(2-sqrt(2))],
				[-1/2, +sqrt(2), +1/2],
				[+1/2, +sqrt(2), +1/2],
				[-1/2, -sqrt(2), +1/2],
				[+1/2, -sqrt(2), +1/2],
			],
			[
				[0, 1],
				[2, 3],
				[4, 5],
				[6, 7],
				[0, 4],
				[1, 5],
				[0, 6],
				[1, 7],
				[2, 4],
				[3, 5],
				[2, 6],
				[3, 7],
				[8, 9],
				[10, 11],
				[12, 13],
				[14, 15],
				[8, 12],
				[9, 13],
				[8, 14],
				[9, 15],
				[10, 12],
				[11, 13],
				[10, 14],
				[11, 15],
				[0, 8],
				[1, 9],
				[2, 10],
				[3, 11],
				[4, 12],
				[5, 13],
				[6, 14],
				[7, 15],
			],
			.1);
	}
}

module 3Dto2D(t) {
	// 3d
	// corners = [1/2 1/2 3/2;
	// 			 1/2 1/2 1/2;
	// 			 -1/2 1/2 1/2;
	// 			 -1/2 1/2 3/2;
	// 			 1/2 -1/2 3/2;
	// 			 1/2 -1/2 1/2;
	// 			 -1/2 -1/2 1/2;
	// 			 -1/2 -1/2 3/2];
	// 2d
	//  2.00000   2.00000
	//  0.66667   0.66667
	// -0.66667   0.66667
	// -2.00000   2.00000
	//  2.00000  -2.00000
	//  0.66667  -0.66667
	// -0.66667  -0.66667
	// -2.00000  -2.00000
	$fn = 20;
	translate([-t,0,0]) scale(10) {
		polyhedron2([
				[-2/3, 2/3, 0],
				[ 2/3, 2/3, 0],
				[ 2/3,-2/3, 0],
				[-2/3,-2/3, 0],
				[-2, 2, 0],
				[ 2, 2, 0],
				[ 2,-2, 0],
				[-2,-2, 0],
			],
			[
				[0, 1],
				[1, 2],
				[2, 3],
				[3, 0],
				[4, 5],
				[5, 6],
				[6, 7],
				[7, 4],
				[0, 4],
				[1, 5],
				[2, 6],
				[3, 7],
			],
			.1);
	}
	// 3d
	// corners = [1/2 1/2 3/2;
	// 			 1/2 1/2 1/2;
	// 			 -1/2 1/2 1/2;
	// 			 -1/2 1/2 3/2;
	// 			 1/2 -1/2 3/2;
	// 			 1/2 -1/2 1/2;
	// 			 -1/2 -1/2 1/2;
	// 			 -1/2 -1/2 3/2];
	// 2d
	//  0.00000   3.41421 
	//  0.70711   0.50000 
	//  0.00000   0.58579 
	// -0.70711   0.50000
	//  0.00000  -3.41421 
	//  0.70711  -0.50000
	//  0.00000  -0.58579 
	// -0.70711  -0.50000

	translate([t,0,0]) scale(10) {
		polyhedron2([
				[-(2+sqrt(2)), 0, 0],
				[+(2+sqrt(2)), 0, 0],
				[-(2-sqrt(2)), 0, 0],
				[+(2-sqrt(2)), 0, 0],
				[-1/2, sqrt(2), 0],
				[1/2, sqrt(2), 0],
				[-1/2, -sqrt(2), 0],
				[1/2, -sqrt(2), 0],
			],
			[
				[0, 1],
				[2, 3],
				[4, 5],
				[6, 7],
				[0, 4],
				[1, 5],
				[0, 6],
				[1, 7],
				[2, 4],
				[3, 5],
				[2, 6],
				[3, 7],
			],
			.1);
	}
}

rotate([t, 0, 0]) {
 	4Dto3D(40);
 	3Dto2D(40);
}
