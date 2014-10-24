(load "~/software/blueprints/3D/openscad/opensexp.lisp")

(defparameter *side-length* 50)
(defparameter *thickness* 5)
(defparameter *hinge-width* (/ *side-length* 3))
(defparameter *hinge-embed* *thickness*)
(defparameter *center-to-corner* (* *side-length* (/ (sqrt 3) 3)))
(defparameter *center-to-edge* (/ *center-to-corner* 2))
(defparameter *center-to-corner-ext* (+ (/ *thickness* 2) *center-to-corner*))
(defparameter *center-to-edge-ext* (+ (/ *thickness* 2) *center-to-edge*))
(defparameter *hinge-pin-radius* (/ *thickness* 4))
(defparameter *hinge-pin-length* (/ *hinge-width* 8))
(defparameter *triangle-center-distance* (* -2 *center-to-edge-ext*))

(defun hinge-pin ()
  (scad:rotate
   90 0 0
   (scad:translate 
	(- *hinge-embed* (/ *thickness* 2)) 
	0 
	(- (/ *hinge-width* 2) (* .1 *hinge-pin-length*))
	(scad:cylinder *hinge-pin-radius* (* 1.1 *hinge-pin-length*) :r2 0))
   (scad:translate 
	(- *hinge-embed* (/ *thickness* 2)) 
	0 
	(- (/ *hinge-width* -2) *hinge-pin-length*)
	(scad:cylinder 0 (* 1.1 *hinge-pin-length*) :r2 *hinge-pin-radius*))))

(defun hinge ()
  (scad:rotate 
   90 0 0
	(scad:hull
	 (scad:translate 
	  (- (- *hinge-embed* (/ *thickness* 2))) 
	  0 
	  (/ *hinge-width* -2)
	  (scad:cylinder (/ *thickness* 2) *hinge-width*))
	 (scad:translate 
	  (- *hinge-embed* (/ *thickness* 2)) 
	  0 
	  (/ *hinge-width* -2)
	  (scad:cylinder (/ *thickness* 2) *hinge-width*)))))

(defun triangle ()
; since I'm making my triangle by "radiating from the center" one
; unit, I need to scale by something to get the right side length
  (let* ((corner-locs (loop for i from 0 to 2 
						 collecting (list (* *center-to-corner* 
											 (scad:cosd (* i 120)))
										  (* *center-to-corner* 
											 (scad:sind (* i 120)))
										  0)))
		 (sphere (scad:sphere (/ *thickness* 2))))
	(scad:hull
	 ;; pretty sure there's some way to split a list or apply a
	 ;; function without doing this explicit deal
	 (mapcar (lambda (corner)
			   (scad:translate (first corner)
							   (second corner)
							   (third corner)
							   sphere))
			 corner-locs))))

(defun hinged-triangle (sides)
  ;; would like to apply these things just once, but the
  ;; scaling-for-clearance has to happen before the translation. again
  ;; arguing for a datastructure that has both the string AND the real
  ;; coordinates
  (flet ((rotcopy (x) (scad:scad-union 
					   (loop for i in sides collecting
							(scad:rotate 0 0 (* i 120)
										 x)))))
	(let* ((hinges (rotcopy (scad:translate 
							 (- *center-to-edge-ext*) 0 0 
							 (hinge))))
		   (hinge-slots (rotcopy (scad:translate 
								  (- *center-to-edge-ext*) 0 0 
								  (scad:scale 1.1 1.1 2 (hinge)))))
		   (hinge-pins (rotcopy (scad:translate 
								 (- *center-to-edge-ext*) 0 0 
								 (hinge-pin))))
		   (hinge-pin-holes 
			(scad:scad-union
			 (rotcopy (scad:translate 
					   (- *center-to-edge-ext*) 0 0
					   (scad:scale 1.1 1.1 1.1 (hinge-pin))))
			 (rotcopy (scad:translate 
					   (- (+ *center-to-edge-ext* *hinge-embed*)) 0 0 
					   (scad:scale 1.1 1.1 1.1 (hinge-pin)))))))
	  (scad:scad-union 
	   hinge-pins
	   (scad:difference
	   	hinges
	   	hinge-pin-holes)
	   (scad:difference
		(triangle)
		hinge-slots
		hinge-pin-holes))
	  )))

(scad:emit
;  (scad:scad-union
;   (hinge-pin)
;   (hinge))
 (scad:scad-union
  (hinged-triangle '(0))
  (scad:translate *triangle-center-distance* 0 0
  				  (scad:rotate 0 0 180 (hinged-triangle '(0)))))
 :file "/home/dr/software/blueprints/3D/openscad/360hinge.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
