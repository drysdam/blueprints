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
			 -20 -20  20
			 -20  20 -20;
			  20  20 -20;
			  20 -20 -20;
			 -20 -20 -20
			 ]';
hyperfacee = [1 2; 2 3; 3 4; 4 1; 5 6; 6 7; 7 8; 8 5; 1 5; 2 6; 3 7; 4 8];

								#rotate3(hyperface,10,0,0);
printf("include <coordinates.scad>;\n");

# polyhedron(rotate2(hyperface,1), [1 2; 2 3; 3 4; 4 1]);
# polyhedron(rotate2(hyperface,2), [1 2; 2 3; 3 4; 4 1]);

x = str2num(argv(){1});
y = str2num(argv(){2});
z = str2num(argv(){3});
polyhedron(rotate3(hyperfacev,x,y,z), hyperfacee)
