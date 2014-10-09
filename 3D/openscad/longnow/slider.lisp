(load "opensexp.lisp")

(defun slider ()
	(scad:scale 25.4 25.4 25.4
	   (scad:cube 1 1 1)))

; define the shape in relative terms, then scale it to be
; absolute. the only problem is the relative width/depth of the
; cutter.
(defun slider ()
  ; TODO: need to adjust these so when scaled up to inches later, they
  ; are right...
  (let* ((cutter-radius .5)
		 (cutter-depth .250)
		 (backplate-thickness .250)
		 (cutter (scad:cylinder cutter-radius cutter-depth)))
	(scad:difference
	 (scad:translate 0 -.5 (* -1 (+ backplate-thickness .01))
					 (scad:cube 23 7 (+ backplate-thickness cutter-depth)))
	 (scad:translate 10 0 0 (scad:cube 6 7 cutter-depth))
	 (scad:translate 0 cutter-radius 0
					 (scad:mill '((0 0) 
								  (6 0) 
								  (9 3) 
								  (11 3) 
								  (18 2) 
								  (22 0) 
								  (23 0))
								cutter)
					 (scad:mill '((0 6) 
								  (6 6) 
								  (9 3) 
								  (11 3) 
								  (18 4) 
								  (22 6) 
								  (23 6))
								cutter)))))

(scad:emit
 (slider)
 :file "/home/dr/software/blueprints/3D/openscad/longnow/slider.scad"
 :fn 20)