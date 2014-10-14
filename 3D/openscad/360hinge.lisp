(load "~/software/blueprints/3D/openscad/opensexp.lisp")

(defparameter *side-length* 30)
(defparameter *thickness* 5)
(defparameter *flex-thickness* 2)

(defun hinge-female ()
  (scad:scad-union
   (scad:translate (- (/ *side-length* 8) (/ *flex-thickness* 4)) 0 0
				   (scad:cube (- (/ *side-length* 4) (/ *flex-thickness* 2))
							  (/ *side-length* 2)
							  *flex-thickness* 
							  :center t))
   (scad:translate (/ *side-length* 4)
				   0 
				   0 
				   (scad:difference
					(scad:rotate 90 0 0 
								 (scad:cylinder 
								  *flex-thickness*
								  (/ *side-length* 2)
								  :center t))
					(scad:rotate 90 0 0 
								 (scad:cylinder 
								  (- (/ *flex-thickness* 2) .1)
								  (/ *side-length* 1.5)
								  :center t))))))

(defun hinge-male ()
  (scad:translate (/ *side-length* 8) 0 0 
				  (scad:translate 0 
								  (- (/ *side-length* 3) (/ *flex-thickness* 2))
								  0 
								  (scad:cube (/ *side-length* 4) 
											 *flex-thickness*
											 *flex-thickness* 
											 :center t))
				  (scad:translate 0 
								  (+ (/ *side-length* -3) (/ *flex-thickness* 2))
								  0 
								  (scad:cube (/ *side-length* 4) 
											 *flex-thickness*
											 *flex-thickness* 
											 :center t))
				  (scad:translate (/ *side-length* 8)
								  0 
								  0 
								  (scad:rotate 90 0 0 
											   (scad:cylinder 
												(/ *flex-thickness* 2)
												(/ *side-length* 1.5)
												:center t)))))


(defun hinged-triangle ()
  (scad:scad-union 
   (triangle)))
								  

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
 (scad:scad-union
  (hinge-female)
  (hinge-male)
  )
 :file "/home/dr/software/blueprints/3D/openscad/360hinge.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
