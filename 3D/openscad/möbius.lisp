(load "opensexp.lisp")

(defun pairwise-hull (lst)
  (let ((lst1 lst)
		(lst2 (append (cdr lst) (list (car lst)))))
	(mapcar #'scad:hull lst1 lst2)))

(defun bar (length thickness)
  (scad:translate (/ thickness -2) 0 0 
			 (scad:scad-union
			  (scad:translate 0 0 (/ length 2) 
							  (scad:rotate 0 90 0 
										   (scad:cylinder 1 thickness)))
			  (scad:translate 0 0 (/ length -2) 
							  (scad:rotate 0 90 0 
										   (scad:cylinder 1 thickness))))))

(defun loop-de-loop (height radius elements flip)
  (let ((width (/ (* 2 pi radius) elements))
		(elem-flip-angle (/ flip elements))
		(elem-face-angle (/ 360 elements)))
	(loop for i from 0 upto (- elements 1)
	   collecting 
		 (scad:rotate 0 0 (* i elem-face-angle)
			  (scad:translate 0 radius 0 
				  (scad:rotate (* i elem-flip-angle) 0 0
							   (bar height width)))))))

(emit (bar 10 2)
	  :file "möbius.scad")

(emit (loop-de-loop 10 30 50 180)
	  :file "möbius.scad")

(emit (pairwise-hull (loop-de-loop 10 30 50 180))
	  :file "möbius.scad")
