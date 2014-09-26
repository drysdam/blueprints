; native OpenSCAD commands

(defun circle (radius)
  (format nil "circle(r=~a);" radius))

(defun cylinder (radius height)
  (format nil "cylinder(r=~a,h=~a);" radius height))

(defun cube (x y z &key (center '()))
  (format nil "cube([~a,~a,~a], center=~:[false~;true~]);" x y z center))

(defun sphere (radius)
  (format nil "sphere(r=~a);" radius))

(defun scale (x y z &rest rest)
  (format nil "scale([~a,~a,~a]){~{~a~}}" x y z rest))

(defun translate (x y z &rest rest)
  (format nil "translate([~a,~a,~a]){~{~a~}}" x y z rest))

(defun rotate (x y z &rest rest)
  (format nil "rotate([~a,~a,~a]){~{~a~}}" x y z rest))

(defun difference (first &rest rest)
  (format nil "difference() {~a~{~a~}}" first rest))

(defun scad-intersection (first &rest rest)
  (format nil "intersection() {~a~{~a~}}" first rest))

(defun scad-union (&rest rest)
  (format nil "union() {~{~a~}}" rest))
  
(defun linear-extrude (height scad)
  (format nil "linear_extrude(height=~a, convexity=10) {~a}" height scad))

(defun polygon (pointlist edgelist)
  (format nil "polygon([~{[~{~,6f~^,~}]~^,~}], [[~{~a~^,~}]]);" 
  		  pointlist edgelist))

; DIY OpenSCAD commands

(defun emit (scad &key (file *STANDARD-OUTPUT*) (fn 20))
  (let ((fstr (if (listp scad)
				  "~{~a~}"
				  "~a")))
	(if (eq file *STANDARD-OUTPUT*)
		(progn
		  (format t "$fn=~a;" fn)
		  (format t fstr scad))
		(with-open-file (s file :direction :output :if-exists :supersede)
		  (progn
			(format s "$fn=~a;" fn)
			(format s fstr scad))))
	't))

(defun arc (radius from-angle to-angle)
  (let ((real-to-angle (if (> to-angle from-angle)
						   to-angle
						   (+ 360 to-angle))))
	(polygon
	 (append '((0 0))
			 (loop for a from from-angle upto real-to-angle collect
				  (list (* radius (cosd a)) (* radius (sind a))))
			 '((0 0)))
	(loop for p upto (+ (- real-to-angle from-angle) 2) collect p))))
	

; machinery/helpers

(defun cosd (degrees)
  (cos (* degrees (/ pi 180))))

(defun sind (degrees)
  (sin (* degrees (/ pi 180))))

(defun merge-scad (l)
  (reduce 
   (lambda (a b) (concatenate 'string a b))
   l))

; test cases
(emit
 (scale .5 .5 .5
		(let ((result '()))
		  (dotimes (i 3 (merge-scad result))
			(push (rotate (* i 120) 0 0 
						  (translate 0 10 0 
									 (cube 1 1 1))) 
				  result))))
 :file "/tmp/blah")

(emit
 (difference
  (translate -50 -50 -50 
			 (cube 100 100 100))
  (let ((result '()))
	(dotimes (i 50 (merge-scad result))
	  (push (translate (- (random 100) 50) 
					   (- (random 100) 50)
					   (- (random 100) 50)
					   (sphere 5))
			result))))
 :file "/tmp/blah")

(emit 
 (difference
  (cylinder 50 60)
  (translate 10 0 -10 (cylinder 50 80)))
 :file "/tmp/blah")

(emit 
 (scad-union 
  (merge-scad (loop for i upto 30 collect
				   (translate (random 50) 0 (random 50) 
							  (sphere (random 5)))))
  (rotate 0 0 -60 (merge-scad (loop for i upto 30 collect
								  (translate (random 50) 0 (random 50) 
											 (sphere (random 5)))))))
 :file "/tmp/blah")

(emit 
 (difference
  (cylinder 50 60)
  (translate 0 0 -10 (linear-extrude 80 (arc 55 0 300)))
  (scad-union 
   (merge-scad (loop for i upto 50 collect
					(translate (random 50) 0 (random 50) 
							   (sphere (random 5)))))
   (rotate 0 0 -60 (merge-scad (loop for i upto 50 collect
								   (translate (random 50) 0 (random 50) 
											  (sphere (random 5))))))))
 :file "/tmp/blah")

(emit 
; (scad-intersection (cube 1 1 1) (sphere .5))
 (scad-union (cube 5 5 5 :center 't) (sphere (* (sqrt 2) 2.5)))
 :file "/tmp/blah"
 :fn 200)

