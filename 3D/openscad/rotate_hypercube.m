0; 

# for no reason:
# vertices are columns
# edges are rows

function result = rotate2(vertices, degrees)
  radians = pi*degrees/180;
  rot = [cos(radians) -sin(radians); 
		 sin(radians)  cos(radians)];
  result = rot * vertices;
endfunction

function result = rotate3(vertices, xdegrees, ydegrees, zdegrees)
  xradians = pi*xdegrees/180;
  yradians = pi*ydegrees/180;
  zradians = pi*zdegrees/180;
  xrot = [
		 1             0             0;
		 0             cos(xradians) -sin(xradians); 
		 0             sin(xradians)  cos(xradians);
		 ];
  yrot = [
		 cos(yradians)  0             -sin(yradians); 
		 0              1             0;
		 sin(yradians)  0             cos(yradians);
		 ];
  zrot = [
		 cos(zradians) -sin(zradians)  0;
		 sin(zradians)  cos(zradians)  0;
		 0             0               1;
		 ];
  result = xrot * yrot * zrot * vertices;
endfunction

function result = rotate4(vertices, xydegrees, yzdegrees, zxdegrees,
						  xwdegrees, ywdegrees, zwdegrees)
  xyrad = pi*xydegrees/180;
  yzrad = pi*yzdegrees/180;
  zxrad = pi*zxdegrees/180;
  xwrad = pi*xwdegrees/180;
  ywrad = pi*ywdegrees/180;
  zwrad = pi*zwdegrees/180;
  
# XY plane     
  xy = [
		cos(xyrad) sin(xyrad) 0 0 ;
		-sin(xyrad) cos(xyrad) 0 0 ;
		0    0   1 0 ;
		0    0   0 1 ;
        ];
  
# YZ plane     
  yz = [
		1   0    0   0 ;
		0  cos(yzrad) sin(yzrad) 0 ;
		0 -sin(yzrad) cos(yzrad) 0 ;
		0   0    0   1 ;
        ];

# ZX plane     
  zx = [
		cos(zxrad) 0 -sin(zxrad) 0 ;
		0   1   0   0 ;
		sin(zxrad) 0  cos(zxrad) 0 ;
		0   0   0   1 ;
        ];

# XW plane     
  xw = [
		cos(xwrad) 0 0 sin(xwrad) ;
		0   1 0  0   ;
		0   0 1  0   ;
		-sin(xwrad) 0 0 cos(xwrad) ;
		];
  
# YW plane     
  yw = [
		1  0   0   0   ;
		0 cos(ywrad) 0 -sin(ywrad) ;
		0  0   1   0   ;
		0 sin(ywrad) 0  cos(ywrad) ;
		];
  
# ZW plane
  zw = [
		1 0  0     0   ;
		0 1  0     0   ;
		0 0 cos(zwrad) -sin(zwrad) ;
		0 0 sin(zwrad)  cos(zwrad) ;
        ];

  result = xy * vertices;
endfunction

function result = cross4(U, V, W)
								# 4D cross product takes 3 4-vectors and
								# produces something perpendicular to
								# all.
        #             +-           -+
        #             | i  j  k  l  |
        # X4(U,V,W) = | U0 U1 U2 U3 |
        #             | V0 V1 V2 V3 |
        #             | W0 W1 W2 W3 |
        #             +-           -+


        #  |U1 U2 U3|    |U0 U2 U3|    |U0 U1 U3|    |U0 U1 U2|
        # i|V1 V2 V3| - j|V0 V2 V3| + k|V0 V1 V3| - l|V0 V1 V2|
        #  |W1 W2 W3|    |W0 W2 W3|    |W0 W1 W3|    |W0 W1 W2|

  result = zeros(4,1);
  result(1) = det([U(2:4)'; 
				   V(2:4)'; 
				   W(2:4)']);
  result(2) = -det([U(1) U(3) U(4);
					V(1) V(3) V(4);
					W(1) W(3) W(4)]);
  result(3) = det([U(1) U(2) U(4);
				   V(1) V(2) V(4);
				   W(1) W(2) W(4)]);
  result(4) = -det([U(1:3)'; 
					V(1:3)'; 
					W(1:3)']);
endfunction

function result = project43(vertices, perspective)
  from = [100 100 100 100]';
  to = [0 0 0 0]';
  up = [0 0 1 0]';
  over = [0 0 0 1]'; # ???

  D = (to - from);
  D /= vecmag(D);
  
  A = cross4(up, over, D);
  A /= vecmag(A);

  B = cross4(over, D, A);
  B /= vecmag(B);

  C = cross4(D, A, B);

  eyevertices = [A'; B'; C'; D'] * (vertices - from);

  if (perspective)
	theta4 = 60 * pi/180; # ?
	T = tan(theta4/2);
								# this ends up normalized really tiny.
								# website had some info on filling a
								# 1x1x1 box, but let's just x100 for
								# now.
	result = 100 * [
					eyevertices(1,:)./(eyevertices(4,:) * T);
					eyevertices(2,:)./(eyevertices(4,:) * T);
					eyevertices(3,:)./(eyevertices(4,:) * T)
					];
  else
	result = eyevertices(1:3,:);
  endif
endfunction

function result = polyhedron(vertices, edges)
  for e = 1:rows(edges)
	edge = edges(e,:);
	v1 = edge(1);
	v2 = edge(2);
	printf("line_xyz([%f, %f, %f], [%f, %f, %f], 5);\n", vertices(:,v1), vertices(:,v2));
  endfor
endfunction

								# I'm writing these as rows for ease of
								# editing, but not the transpose to make
								# column vertices
hyperfacev = [
			 -20  20  20;
			  20  20  20;
			  20 -20  20;
			 -20 -20  20;
			 -20  20 -20;
			  20  20 -20;
			  20 -20 -20;
			 -20 -20 -20
			 ]';
hyperfacev = [
			 -20  20  20 0;
			  20  20  20 0;
			  20 -20  20 0;
			 -20 -20  20 0;
			 -20  20 -20 0;
			  20  20 -20 0;
			  20 -20 -20 0;
			 -20 -20 -20 0;
			 ]';
hyperfacee = [1 2; 2 3; 3 4; 4 1; 5 6; 6 7; 7 8; 8 5; 1 5; 2 6; 3 7; 4 8];

								#rotate3(hyperface,10,0,0);
printf("include <coordinates.scad>;\n");

# polyhedron(rotate2(hyperface,1), [1 2; 2 3; 3 4; 4 1]);
# polyhedron(rotate2(hyperface,2), [1 2; 2 3; 3 4; 4 1]);
#polyhedron(rotate3(hyperfacev,x,y,z), hyperfacee)

#xy = str2num(argv(){1});
xy = 0;
yz = 0;
zx = 0;
xw = 0;
yw = 0;
zw = 0;
polyhedron(project43(rotate4(hyperfacev,xy,yz,zx,xw,yw,zw),true),hyperfacee);
#polyhedron(project43(rotate4(hyperfacev,xy,yz,zx,xw,yw,zw),false),hyperfacee);
