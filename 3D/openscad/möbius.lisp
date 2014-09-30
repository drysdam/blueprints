(load "opensexp.lisp")

(defun loop-de-loop (height radius elements flip)
  (let ((width (/ (* 2 pi radius) elements))
		(elem-flip-angle (/ flip elements))
		(elem-face-angle (/ 360 elements)))
	(loop for i from 0 upto (- elements 1)
	   collecting 
		 (scad:rotate 0 0 (* i elem-face-angle)
			  (scad:translate 0 radius 0 
				  (scad:rotate (* i elem-flip-angle) 0 0
					   (scad:cube width 2 height :center 't)))))))

(emit (loop-de-loop 10 30 100 180)
	  :file "möbius.scad")