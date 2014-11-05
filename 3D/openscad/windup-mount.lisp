(load "~/software/blueprints/3D/openscad/opensexp.lisp")

(defparameter axle-rad (scad:in->mm (/ .060 2)))

(defun windup ()
  (scad:scad-union
   (scad:cube 
	(scad:in->mm 1.005) (scad:in->mm .316) (scad:in->mm .554) :center 't)
   (scad:translate 
	(scad:in->mm (- (/ 1.005 2) (+ .200 (/ .060 2))))
	0 
	(scad:in->mm (- (- (/ .554 2) (+ .129 (/ .060 2)))))
	(scad:rotate 
	 90 0 0 
	 (scad:cylinder 
	  axle-rad (scad:in->mm 1.967) :center 't)))
   (scad:translate 
	(scad:in->mm (- (- (/ 1.005 2) (+ .253 (/ .060 2)))))
	(scad:in->mm (+ (/ .316 2) .020))
	0
	(scad:rotate 
	 90 0 0 
	 (scad:cylinder 
	  (scad:in->mm (/ .060 2)) (scad:in->mm .885))))
   (scad:translate 
	(scad:in->mm (- (- (/ 1.005 2) (+ .253 (/ .060 2)))))
	(scad:in->mm (- .390))
	0
	(scad:rotate 
	 90 0 0 
	 (scad:cylinder 
	  (scad:in->mm (/ .185 2)) (scad:in->mm .315))))
   (scad:translate 
	(scad:in->mm (- (- (/ 1.005 2) (+ .253 (/ .060 2)))))
	(scad:in->mm (- .460))
	0
	(scad:rotate 
	 90 0 0 
	 (scad:cylinder 
	  (scad:in->mm (/ .220 2)) (scad:in->mm .245))))
   )
  )

(defun windup-mount ()
  (scad:difference
   (scad:translate
	-10 0 -2
	(scad:cube 
	 50 12 15
	 :center 't))
   (scad:translate
	-10 0 0
	(scad:cube 
	 45 8 15
	 :center 't))
   (windup)
   )
)

(defun windup-wheel ()
  (scad:difference
   (scad:cylinder 9 10 :center 't)
   (scad:cylinder axle-rad 4 :center 't)
   )
)

(scad:emit
 (scad:scad-union
;  (windup)
  (scad:translate 
   (scad:in->mm (- (/ 1.005 2) (+ .200 (/ .060 2))))
   19 
   (scad:in->mm (- (- (/ .554 2) (+ .129 (/ .060 2)))))
   (scad:rotate 90 0 0 (windup-wheel)))
  (scad:translate 
   (scad:in->mm (- (/ 1.005 2) (+ .200 (/ .060 2))))
   -19 
   (scad:in->mm (- (- (/ .554 2) (+ .129 (/ .060 2)))))
   (scad:rotate 90 0 0 (windup-wheel)))
  (windup-mount)
  )
 :file "/home/dr/software/blueprints/3D/openscad/windup-mount.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
