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
	printf("line_xyz([%f, %f], [%f, %f], 5);\n", vertices(:,v1), vertices(:,v2));
  endfor
endfunction

hyperface = [-20 20; 20 20; 20 -20; -20 -20]';
rotate2(hyperface,10);
printf("include <coordinates.scad>;\n");

# polyhedron(rotate2(hyperface,1), [1 2; 2 3; 3 4; 4 1]);
# polyhedron(rotate2(hyperface,2), [1 2; 2 3; 3 4; 4 1]);

t = str2num(argv(){1});
polyhedron(rotate2(hyperface,t), [1 2; 2 3; 3 4; 4 1]);
