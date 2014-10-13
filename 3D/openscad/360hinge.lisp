(load "~/software/blueprints/3D/openscad/opensexp.lisp")

(defun equilateral-triangle (side-length)
  ; since I'm making my triangle by "radiating from the center" one
  ; unit, I need to scale by something to get the right side length
  (scad:difference
   (let ((s (* side-length (/ (sqrt 3) 3))))
	 (scad:scale s s 1 
				 (scad:polygon 
				  (loop for i from 0 to 2 
					 collecting (list (scad:cosd (* i 120)) 
									  (scad:sind (* i 120))))
				  '(0 1 2 0))))
   (scad:translate (* side-length (/ (sqrt 3) -6)) 0 0 
				   (scad:cube (/ side-length 3) 
							  (/ side-length 3) 
							  2 :center t))))


(scad:emit
 (equilateral-triangle 10)
 :file "/home/dr/software/blueprints/3D/openscad/360hinge.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
