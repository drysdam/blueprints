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

function result = polyhedron(vertices, edges)
  for e = 1:rows(edges)
	edge = edges(e,:);
	v1 = edge(1);
	v2 = edge(2);
	printf("line_xyz([%d, %d], [%d, %d], 5);\n", vertices(:,v1), vertices(:,v2));
  endfor
endfunction

#rotate2(square,10)

t = str2num(argv(){1});
square = [-20 20; 20 20; 20 -20; -20 -20]';
printf("include <coordinates.scad>;\n");
polyhedron(rotate2(square,t), [1 2; 2 3; 3 4; 4 1]);
