(defun circle (radius)
  (format nil "circle(r=~a);" radius))

(defun cylinder (radius height)
  (format nil "cylinder(r=~a,h=~a);" radius height))

(defun cube (x y z)
  (format nil "cube([~a,~a,~a]);" x y z))

(defun sphere (radius)
  (format nil "sphere(r=~a);" radius))

(defun emit (scad &optional (file *STANDARD-OUTPUT*))
  (let ((fstr (if (listp scad)
				  "~{~a~}"
				  "~a")))
	(if (eq file *STANDARD-OUTPUT*)
		(format t fstr scad)
		(with-open-file (s file :direction :output :if-exists :supersede)
		  (format s fstr scad)))
	't))

(defun scale (x y z &rest rest)
  (format nil "scale([~a,~a,~a]){~{~a~}}" x y z rest))

(defun translate (x y z &rest rest)
  (format nil "translate([~a,~a,~a]){~{~a~}}" x y z rest))

(defun rotate (x y z &rest rest)
  (format nil "rotate([~a,~a,~a]){~{~a~}}" x y z rest))

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
 "/tmp/blah")