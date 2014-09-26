(defun circle (&optional (radius 0))
  (format nil "circle(r=~a);" radius))

(defun cube (&key (x 0) (y 0) (z 0))
  (format nil "cube([~a,~a,~a]);" x y z))

(defun emit (scad &optional (file *STANDARD-OUTPUT*))
  (if (eq file *STANDARD-OUTPUT*)
	  (format t "~a" scad)
	  (with-open-file (s file :direction :output :if-exists :supersede)
		(format s "~a" scad)))
  't)

							   