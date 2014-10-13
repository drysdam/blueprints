(load "~/software/blueprints/3D/openscad/opensexp.lisp")

(defparameter *side-length* 10)
(defparameter *thickness* 2)

(defun hinged-triangle ()
  (scad:scad-union 
   (triangle)
   (scad:translate (* *side-length* (/ (sqrt 3) -6)) 0 0 
   				   (scad:cube (/ *side-length* 4) 
   							  (/ *side-length* 2)
   							  (/ *thickness* 4) :center t))
   (scad:translate (* *side-length* (/ (sqrt 3) -4)) 0 0 
				   (scad:cube (/ *side-length* 10) 
							  (/ *side-length* 2)
							  (/ *thickness* 2) :center t))))

(defun notched-triangle ()
  ; since I'm making my triangle by "radiating from the center" one
  ; unit, I need to scale by something to get the right side length
  (scad:difference
   (let ((s (* *side-length* (/ (sqrt 3) 3))))
	 (scad:scale s s *thickness*
				 (scad:polygon 
				  (loop for i from 0 to 2 
					 collecting (list (scad:cosd (* i 120)) 
									  (scad:sind (* i 120))))
				  '(0 1 2 0))))
   (scad:translate (* *side-length* (/ (sqrt 3) -6)) 0 0 
				   (scad:cube (/ *side-length* 3) 
							  (/ *side-length* 1) 
							  (* 2 *thickness*) :center t))))

(defun triangle ()
; since I'm making my triangle by "radiating from the center" one
; unit, I need to scale by something to get the right side length
  (let ((s (* *side-length* (/ (sqrt 3) 3))))
	(scad:scale s s *thickness*
				(scad:polygon 
				 (loop for i from 0 to 2 
					collecting (list (scad:cosd (* i 120)) 
									 (scad:sind (* i 120))))
				 '(0 1 2 0)))))

(scad:emit
 (hinged-triangle)
 :file "/home/dr/software/blueprints/3D/openscad/360hinge.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
