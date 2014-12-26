(load "opensexp.lisp")

(defparameter *alphabet* "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

(defun letter-slice (radius n)
  (let ((letter-f (concatenate 'string (subseq *alphabet* n (1+ n)) "();")))
	(scad:rotate 0 0 (* -1 n (/ 360 26))
				 (scad:translate 0 (- radius 10) 3.3
								 (scad:scale .7 .7 1 letter-f)))))

(defun letter-wheel (radius)
  (scad:scad-union 
   (scad:cylinder radius 3)
   (loop for i from 0 upto 25 collecting
		(letter-slice radius i))))

(defun axle ()
  (scad:cylinder 10 10 :center 't))

(scad:emit 
 (scad:scad-union
  (scad:translate 0 0 5 (axle))
  (letter-wheel 55))
 :fn 26
 :file "decoder1.scad"
 :includes '("NEWletters.scad"))

(scad:emit 
 (scad:difference (scad:translate 0 0 -5
								  (letter-wheel 40))
				  (scad:scale 1.05 1.05 2 (axle)))
 :fn 26
 :file "decoder2.scad"
 :includes '("NEWletters.scad"))

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
