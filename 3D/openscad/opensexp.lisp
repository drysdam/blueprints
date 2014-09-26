(defun circle (radius)
  (format nil "circle(r=~a);" radius))

(defun cube (x y z)
  (format nil "cube([~a,~a,~a]);" x y z))

(defun sphere (radius)
  (format nil "sphere(r=~a);" radius))

(defun emit (scad &optional (file *STANDARD-OUTPUT*))
  (if (eq file *STANDARD-OUTPUT*)
	  (format t "~a" scad)
	  (with-open-file (s file :direction :output :if-exists :supersede)
		(format s "~a" scad)))
  't)

(defun scale (x y z &rest rest)
  (format nil "scale([~a,~a,~a]){~{~a~}}" x y z rest))

(defun translate (x y z &rest rest)
  (format nil "translate([~a,~a,~a]){~{~a~}}" x y z rest))

(defun rotate (x y z &rest rest)
  (format nil "rotate([~a,~a,~a]){~{~a~}}" x y z rest))
