(load "~/software/blueprints/3D/openscad/opensexp.lisp")

(defparameter *side-length* 35)
(defparameter *thickness* 8)
(defparameter *hinge-width* (/ *side-length* 3))
(defparameter *hinge-embed* *thickness*)
(defparameter *center-to-corner* (* *side-length* (/ (sqrt 3) 3)))
(defparameter *center-to-edge* (/ *center-to-corner* 2))
(defparameter *center-to-corner-ext* (+ (/ *thickness* 2) *center-to-corner*))
(defparameter *center-to-edge-ext* (+ (/ *thickness* 2) *center-to-edge*))
(defparameter *hinge-pin-radius* (/ *thickness* 3.5))
(defparameter *hinge-pin-length* (* 1.1 *hinge-width*))
(defparameter *triangle-center-distance* (* -2 *center-to-edge-ext*))

(defun hinge-pin ()
  (scad:rotate
   90 0 0 
	 (scad:cylinder *hinge-pin-radius* (* 1.1 *hinge-pin-length*) :center 't)))

(defun hinge (with-holes)
  (let ((basic-hinge
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
			(scad:cylinder (/ *thickness* 2) *hinge-width*))))))
	(if with-holes
		 (scad:difference
		  basic-hinge
		  (scad:translate 
		   (- *hinge-embed* (/ *thickness* 2)) 0 0 
		   (scad:scale 1.15 1.15 1.15 (hinge-pin)))
		  (scad:translate 
		   (- (- *hinge-embed* (/ *thickness* 2))) 0 0 
		   (scad:scale 1.15 1.15 1.15 (hinge-pin)))
		  (scad:translate 
		   *hinge-embed* 0 0
		   (scad:cube 
			5 (* 2 *hinge-width*) (* 1.55 *hinge-pin-radius*) :center 't))
		  (scad:translate 
		   (- *hinge-embed*) 0 0
		   (scad:cube 
			5 (* 2 *hinge-width*) (* 1.55 *hinge-pin-radius*) :center 't)))
		basic-hinge)))

(defun triangle ()
; since I'm making my triangle by "radiating from the center" one
; unit, I need to scale by something to get the right side length
  (let* ((corner-locs 
		  (loop for i from 0 to 2 
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
  ;; the scaling-for-clearance has to happen before the translation,
  ;; but that would mean the defun only knows about the *shape* not
  ;; the *position*, which is fine in some cases but not in others
  ;; where the positioning (like for the pins) is *part* of the
  ;; shape. again arguing for a datastructure that has both the string
  ;; AND the real coordinates.
  ;;
  ;; in this case, the point of the scaling is just to make a hole big
  ;; enough to allow the pin to rotate, which seems to be true even if
  ;; the centering is off.
  (flet ((rotcopy (x) (scad:scad-union 
					   (loop for i in sides collecting
							(scad:rotate 0 0 (* i 120)
										 x)))))
	(let* ((hinge-slots (rotcopy (scad:translate 
								  (- *center-to-edge-ext*) 0 0 
								  (scad:scale 1.1 1.1 2 (hinge '())))))
		   (hinge-pins (rotcopy (scad:translate 
								 (- *center-to-edge*) 0 0 
								 (hinge-pin)))))
	  (scad:scad-union
	   hinge-pins
	   (scad:difference
		(triangle)
		hinge-slots)))))

(scad:emit
 (scad:scad-union
  (scad:translate 25 25 0 (hinged-triangle '(0)))
  (scad:translate 0 0 0 (hinge 't)))
 :file "/home/dr/software/blueprints/3D/openscad/360hinge.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
