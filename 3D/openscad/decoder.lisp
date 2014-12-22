(load "opensexp.lisp")

(defun letter-slice (radius n)
  (scad:rotate 0 0 (* n (/ 360 26))
			   (scad:translate 0 (- radius 5) 0
							   (scad:scale .1 .1 .1 "k();"))))

(defun letter-wheel (radius)
  (scad:scad-union 
   (scad:cylinder radius 3)
   (loop for i from 1 upto 26 collecting
		(letter-slice radius i))))

(defun axle ()
  (scad:cylinder 10 10 :center 't))

(scad:emit 
 (scad:scad-union
  (scad:translate 0 0 -5 (axle))
  (letter-wheel 55))
 :fn 20
 :file "decoder1.scad"
 :includes '("alphanumeric.scad"))

(scad:emit 
 (scad:difference (scad:translate 0 0 -5
								  (letter-wheel 40))
				  (scad:scale 1.05 1.05 2 (axle)))
 :fn 20
 :file "decoder2.scad"
 :includes '("alphanumeric.scad"))

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
