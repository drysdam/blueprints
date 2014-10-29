(load "~/software/blueprints/3D/openscad/opensexp.lisp")

(defun windup-mount ()
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
	  (scad:in->mm (/ .060 2)) (scad:in->mm 1.967) :center 't)))
   (scad:translate 
	(scad:in->mm (- (- (/ 1.005 2) (+ .253 (/ .060 2)))))
	(scad:in->mm (+ (/ .316 2) .020))
	0
	(scad:rotate 
	 90 0 0 
	 (scad:cylinder 
	  (scad:in->mm (/ .060 2)) (scad:in->mm .885))))
   )
  )

(scad:emit
 (windup-mount)
 :file "/home/dr/software/blueprints/3D/openscad/windup-mount.scad"
 :fn 20)

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
