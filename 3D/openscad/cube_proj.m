0;
								# could do this much more generally, but
								# I want something simple and easy to
								# understand. plus I'm only generating a
								# few points for a particular projection.

								# the setup here is: I have an N
								# dimensional hypercube sitting at (0,
								# 0, ...., 1) a light source at (0, 0,
								# ...., 2) and am projecting down to (0,
								# 0, ..., 0)

function pcorners = unrotated_2dto1d()
  l = [0 2];
  # clockwise starting from the upper right
  corners = [1/2 3/2;
			 1/2 1/2;
			 -1/2 1/2;
			 -1/2 3/2];
  pcorners = zeros(4,1);
  for p = 1:4
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:1);
  endfor
endfunction

function pcorners = rotated_2dto1d()
  l = [0 2];
  # clockwise starting from the top
  corners = [0 1+sqrt(2)/2;
			 sqrt(2)/2 1;
			 0 1-sqrt(2)/2;
			 -sqrt(2)/2 1]; 
  pcorners = zeros(4,1);
  for p = 1:4
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:1);
  endfor
endfunction

function pcorners = unrotated_3dto2d()
  l = [0 0 3];
  # clockwise starting from the upper right, front face
  corners = [1/2 1/2 2;
			 1/2 1/2 1;
			 -1/2 1/2 1;
			 -1/2 1/2 2;
			 1/2 -1/2 2;
			 1/2 -1/2 1;
			 -1/2 -1/2 1;
			 -1/2 -1/2 2];
  pcorners = zeros(8,2);
  for p = 1:8
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:2);
  endfor
endfunction

function pcorners = rotated_3dto2d()
  # l = [0 0 3];
  # # clockwise starting from the top, front face
  # corners = [0 1/2 3/2+sqrt(2)/2;
  # 			 sqrt(2)/2 1/2 1;
  # 			 0 1/2 3/2-sqrt(2)/2;
  # 			 -sqrt(2)/2 1/2 1;
  # 			 0 -1/2 3/2+sqrt(2)/2;
  # 			 sqrt(2)/2 -1/2 1;
  # 			 0 -1/2 3/2-sqrt(2)/2;
  # 			 -sqrt(2)/2 -1/2 1];
  l = [0 0 2];
  # clockwise starting from the top, front face
  corners = [+0          +1/2  +1+sqrt(2)/2;
			 +sqrt(2)/2  +1/2  +1;
			 +0          +1/2  +1-sqrt(2)/2;
			 -sqrt(2)/2  +1/2  +1;
			 +0          -1/2  +1+sqrt(2)/2;
			 +sqrt(2)/2  -1/2  +1;
			 +0          -1/2  +1-sqrt(2)/2;
			 -sqrt(2)/2  -1/2  +1];
  pcorners = zeros(8,2);
  for p = 1:8
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:2);
  endfor
endfunction

function pcorners = unrotated_4dto3d()
  l = [0 0 0 3];
  # clockwise starting from the upper right, front face, posi cube
  corners = [1/2 1/2 1/2 2;
			 1/2 1/2 1/2 1;
			 -1/2 1/2 1/2 1;
			 -1/2 1/2 1/2 2;
			 1/2 -1/2 1/2 2;
			 1/2 -1/2 1/2 1;
			 -1/2 -1/2 1/2 1;
			 -1/2 -1/2 1/2 2;
			 1/2 1/2 -1/2 2;
			 1/2 1/2 -1/2 1;
			 -1/2 1/2 -1/2 1;
			 -1/2 1/2 -1/2 2;
			 1/2 -1/2 -1/2 2;
			 1/2 -1/2 -1/2 1;
			 -1/2 -1/2 -1/2 1;
			 -1/2 -1/2 -1/2 2];
  pcorners = zeros(16,3);
  for p = 1:16
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:3);
  endfor
endfunction

function pcorners = rotated_4dto3d()
  l = [0 0 0 3];
  # clockwise starting from the top, front face, posi cube
  corners = [0 1/2 1/2 1+sqrt(2)/2;
			 sqrt(2)/2 1/2 1/2 1;
			 0 1/2 1/2 1-sqrt(2)/2;
			 -sqrt(2)/2 1/2 1/2 1;
			 0 -1/2 1/2 1+sqrt(2)/2;
			 sqrt(2)/2 -1/2 1/2 1;
			 0 -1/2 1/2 1-sqrt(2)/2;
			 -sqrt(2)/2 -1/2 1/2 1;
			 0 1/2 -1/2 1+sqrt(2)/2;
			 sqrt(2)/2 1/2 -1/2 1;
			 0 1/2 -1/2 1-sqrt(2)/2;
			 -sqrt(2)/2 1/2 -1/2 1;
			 0 -1/2 -1/2 1+sqrt(2)/2;
			 sqrt(2)/2 -1/2 -1/2 1;
			 0 -1/2 -1/2 1-sqrt(2)/2;
			 -sqrt(2)/2 -1/2 -1/2 1];
  pcorners = zeros(16,3);
  for p = 1:16
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:3);
  endfor
endfunction

function pcorners = project(l, corners)
  dims=length(l);
  ccount=2^dims;
  pcorners = zeros(ccount,dims-1);
  for p = 1:ccount
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:dims-1);
  endfor
endfunction

function l = makelight(dims, height)
  l = zeros(1,dims);
  l(dims) = height;
endfunction

function c = makecube(dims, centerheight, rotated)
  ccount=2^dims;
  c = zeros(ccount, dims);
  if !rotated
	c = [ 1/2 centerheight+1/2
		  1/2 centerheight-1/2
		 -1/2 centerheight-1/2
		 -1/2 centerheight+1/2;];
  else 
	c = [0          centerheight+sqrt(2)/2;
		 sqrt(2)/2  centerheight;
		 0          centerheight-sqrt(2)/2;
		 -sqrt(2)/2 centerheight]; 
  endif
  for d=1:dims-2
	[rows cols] = size(c);
	newhalfcol = 1/2*ones(rows,1);
	c = [c(:,1:cols-1) newhalfcol c(:,cols);
		 c(:,1:cols-1) -newhalfcol c(:,cols);		   ]
  endfor
endfunction

dims = 4;
rotated = true;
david = true;
if david
  lightheight = 2;
  cubecenterheight = 1;
else
  lightheight = 3;
  cubecenterheight = 3/2;
endif
l = makelight(dims, lightheight);
c = makecube(dims, cubecenterheight, rotated);
project(l, c)
