(load "opensexp.lisp")

(defvar *thickness* 3)

(defun make-tetrahedron (x y z side-length)
  (let ((newz (+ z (* side-length (sqrt (/ 2 3)))))
		(rad (* side-length (/ (sqrt 3) 3))))
	(list (list x y z)
		  (list (* rad (cos (/ (* 0 2 pi) 3)))
				(* rad (sin (/ (* 0 2 pi) 3)))
				newz)
		  (list (* rad (cos (/ (* 1 2 pi) 3)))
				(* rad (sin (/ (* 1 2 pi) 3)))
				newz)
		  (list (* rad (cos (/ (* 2 2 pi) 3)))
				(* rad (sin (/ (* 2 2 pi) 3)))
				newz))))

(defun draw-tetrahedron (tetrapts)
  (scad:polyhedron tetrapts '((0 1 2) (0 2 3) (0 3 1) (1 2 3))))

(defun outermost-three (tetrapts)
  (let ((largest-x (loop for p in tetrapts
					  maximize (first p)))
		(largest-y (loop for p in tetrapts
					  maximize (second p)))
		(smallest-y (loop for p in tetrapts
					   minimize (second p))))
	(loop for p in tetrapts
	   when (or 
			 (= (first p) largest-x)
			 (= (second p) largest-y)
			 (= (second p) smallest-y))
	   append (list p))))

(defun place-tetrahedron (tetradrwn points) 
  (cons tetradrwn
		(loop for p in points
		   collecting (scad:translate (first p)
									  (second p)
									  (third p) 
									  tetradrwn))))

(scad:emit 
 (draw-tetrahedron (make-tetrahedron 0 0 0 100)) 
 :includes '("coordinates.scad")
 :file "sierpinski.scad")

(scad:emit 
 (place-tetrahedron (draw-tetrahedron (make-tetrahedron 0 0 0 100))
					(outermost-three 
					 (make-tetrahedron 0 0 0 100)))
 :includes '("coordinates.scad")
 :file "sierpinski.scad")
