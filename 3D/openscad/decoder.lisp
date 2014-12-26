(load "opensexp.lisp")



(defun letter-slice (radius n)
  (scad:rotate 0 0 (* n (/ 360 26))
			   (scad:translate 0 (- radius 10) 3.3
							   (scad:scale .7 .7 1 "K();"))))

(defun letter-wheel (radius)
  (scad:scad-union 
   (scad:cylinder radius 3)
   (loop for i from 1 upto 26 collecting
		(letter-slice radius i))))

(defun axle ()
  (scad:cylinder 10 10 :center 't))

(scad:emit (letter-wheel 50)
		   :file "decoder1.scad" 
		   :includes '("letters.scad"))

(scad:emit 
 (scad:scad-union
  (scad:difference (scad:translate 0 0 5
								   (letter-wheel 40))
				   (scad:scale 1.05 1.05 2 (axle)))
  (scad:translate 0 0 5 (axle))
  (letter-wheel 55))
 :fn 26
 :file "decoder1.scad"
 :includes '("letters.scad"))

(scad:emit 
 (scad:difference (scad:translate 0 0 -5
								  (letter-wheel 40))
				  (scad:scale 1.05 1.05 2 (axle)))
 :fn 26
 :file "decoder2.scad"
 :includes '("letters.scad"))

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
