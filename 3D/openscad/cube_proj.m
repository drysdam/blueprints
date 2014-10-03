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
  l = [0 0 2];
  # clockwise starting from the upper right, front face
  corners = [1/2 1/2 3/2;
			 1/2 1/2 1/2;
			 -1/2 1/2 1/2;
			 -1/2 1/2 3/2;
			 1/2 -1/2 3/2;
			 1/2 -1/2 1/2;
			 -1/2 -1/2 1/2;
			 -1/2 -1/2 3/2];
  pcorners = zeros(8,2);
  for p = 1:8
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:2);
  endfor
endfunction

function pcorners = rotated_3dto2d()
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
  l = [0 0 0 2];
  # clockwise starting from the upper right, front face, posi cube
  corners = [1/2 1/2 1/2 3/2;
			 1/2 1/2 1/2 1/2;
			 -1/2 1/2 1/2 1/2;
			 -1/2 1/2 1/2 3/2;
			 1/2 -1/2 1/2 3/2;
			 1/2 -1/2 1/2 1/2;
			 -1/2 -1/2 1/2 1/2;
			 -1/2 -1/2 1/2 3/2;
			 1/2 1/2 -1/2 3/2;
			 1/2 1/2 -1/2 1/2;
			 -1/2 1/2 -1/2 1/2;
			 -1/2 1/2 -1/2 3/2;
			 1/2 -1/2 -1/2 3/2;
			 1/2 -1/2 -1/2 1/2;
			 -1/2 -1/2 -1/2 1/2;
			 -1/2 -1/2 -1/2 3/2];
  pcorners = zeros(16,3);
  for p = 1:16
	v = corners(p,:);
	proj = abs(norm(l)^2/(dot(v-l,l))) * (v-l);
	pcorners(p,:) = proj(1:3);
  endfor
endfunction

function pcorners = rotated_4dto3d()
  l = [0 0 0 2];
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

# unrotated_2dto1d()
# rotated_2dto1d()
# unrotated_3dto2d()
# rotated_3dto2d()
# unrotated_4dto3d()
rotated_4dto3d()
