(load "opensexp.lisp")

(defun random-line (start length)
  (let* ((random-dx (float (/ (random (* length 100)) 100)))
		 (random-dy (sqrt (- (* length length) (* random-dx random-dx)))))
	(list start (list (+ (first start) random-dx)
					  (+ (second start) random-dy)))))

(defun fractal-helper (line depth)
  (let ((x1 (first (first line)))
		(y1 (second (first line)))
		(x2 (first (second line)))
		(y2 (second (second line))))
	(if (zerop depth)
		'()
		(let* ((frac (float (/ (random 100) 100)))
			   (start (list (+ x1 (* frac (- x2 x1)))
							(+ y1 (* frac (- y2 y1)))))
			   (length (/ (sqrt (+ (expt (- x2 x1) 2) 
								   (expt (- y2 y1) 2))) 2))
			   (newline (random-line start length)))
		  (cons newline	(fractal-helper newline (- depth 1)))))))

(defun fractal (depth)
  (let ((baseline '((0 0) (100 100))))
	(cons baseline (fractal-helper baseline depth))))

(defun snowflake-branch () 
  (let ((lines (fractal 5)))
	(loop for line in lines collecting
		 (scad:line-xyz (first line) (second line))
	)))

(defun snowflake ()
  (let ((branch (snowflake-branch)))
	(loop for ang from 30 to 330 by 60 collecting
		 (scad:rotate 0 0 ang branch))))

(scad:emit (snowflake)
	  :file "snowflake.scad")

;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
