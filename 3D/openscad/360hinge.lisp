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
(defparameter *hinge-pin-length* (* *hinge-width* 2))

(defun hinge-pin ()
  (scad:rotate 90 0 0 (scad:cylinder *hinge-pin-radius* *hinge-pin-length*)))

(defun hinge ()
  (scad:rotate 90 0 0
			   (scad:hull
				(scad:translate (* -1 *hinge-embed*) 0 (/ *hinge-width* -2)
								(scad:cylinder (/ *thickness* 2) *hinge-width*))
				(scad:translate *hinge-embed* 0 (/ *hinge-width* -2)
								(scad:cylinder (/ *thickness* 2) *hinge-width*)))))

; this would be a lot simpler as a minkowski hull...
(defun triangle ()
; since I'm making my triangle by "radiating from the center" one
; unit, I need to scale by something to get the right side length
  (let* ((corners (loop for i from 0 to 2 
					 collecting (list (* *center-to-corner* (scad:cosd (* i 120)))
									  (* *center-to-corner* (scad:sind (* i 120)))
									  0))))
	(scad:scad-union
	 (scad:scale 1 1 *thickness*
				 (scad:polygon (mapcar
								(lambda (corner)
								  (list (car corner) (cadr corner)))
								corners) '(0 1 2 0)))
	 (scad:pairwise-line corners
						 (scad:sphere (/ *thickness* 2))))))

(defun hinged-triangle ()
  (let* ((hinge (scad:translate (- *center-to-edge-ext*) 0 0 (hinge)))
		 (hinge-slot (scad:translate (- *center-to-edge-ext*) 0 0 
									 (scad:scale 1.1 1.05 2 (hinge))))
		 (hinge-pin (scad:translate (- (- *center-to-edge* (/ *hinge-embed* 2))) 
									(/ *hinge-pin-length* 2) 
									0 
									(hinge-pin))))
	(scad:scad-union 
	 hinge
	 hinge-pin
	 (scad:difference
	  (triangle)
	  hinge-slot))))

(scad:emit
  (hinged-triangle)
 :file "/home/dr/software/blueprints/3D/openscad/360hinge.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
