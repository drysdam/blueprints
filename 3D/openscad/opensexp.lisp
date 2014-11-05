; todo: 
;
; - global *units* so I can use mm or thous (or others) and the right
;   open openscad comes out
;
; - radius/diameter option somehow (macro? keyword?)
;
; - move some helpers, like (cosd) and (sind) into a more general
;   location for ALL lisp program, not just opensexp ones
;
; - placement/alignment helpers. for instance, I don't care how I have
;   to move--I want this center to be the same as *that* center. make
;   it so. another example: given two points and two radii, construct
;   my item at the intersection of those two circles. that way *I*
;   don't have to do the math

;; to enable "live-coding:, do this, but with only two ;s, at the end
;; of the file:
;;;;;;;; Local Variables:
;;;;;;;; eval: (slime-eval-on-save)
;;;;;;;; End:
;; that's not a slime function, but my own

(defpackage :scad
  (:use :common-lisp)
  (:export 
   :in->mm
   :cosd
   :sind
   :line-xyz
   :pairwise-line
   :mill
   :arc
   :emit
   :hull
   :circle
   :cylinder
   :cube
   :sphere
   :scale
   :translate
   :rotate
   :difference
   :scad-intersection
   :scad-union
   :linear-extrude
   :polygon
   :polyhedron))

(in-package :scad)

; native OpenSCAD commands

(defun circle (radius)
  (format nil "circle(r=~,6f);" radius))

(defun cylinder (radius height &key (r2 radius) (center '()))
  (format nil "cylinder(r1=~,6f,r2=~,6f,h=~,6f, center=~:[false~;true~]);" 
		  radius r2 height center))

(defun cube (x y z &key (center '()))
  (format nil "cube([~,6f,~,6f,~,6f], center=~:[false~;true~]);" x y z center))

(defun sphere (radius)
  (format nil "sphere(r=~,6f);" radius))

(defun scale (x y z &rest rest)
  (format nil "scale([~,6f,~,6f,~,6f]){~{~a~}};" x y z rest))

(defun translate (x y z &rest rest)
  (format nil "translate([~,6f,~,6f,~,6f]){~a};" x y z (merge-scad rest)))

(defun rotate (x y z &rest rest)
  (format nil "rotate([~,6f,~,6f,~,6f]){~a};" x y z (merge-scad rest)))

(defun difference (first &rest rest)
  (format nil "difference() {~a~{~a~}};" first rest))

(defun scad-intersection (&rest rest)
  (format nil "intersection() {~a};" (merge-scad rest)))

(defun scad-union (&rest rest)
  (format nil "union() {~a};" (merge-scad rest)))
  
(defun linear-extrude (height scad)
  (format nil "linear_extrude(height=~,6f, convexity=10) {~a};" height scad))

(defun hull (&rest scad)
  (format nil "hull () {~a};" (merge-scad scad)))

(defun polygon (pointlist edgelist)
  (format nil "polygon([~{[~{~,6f~^,~}]~^,~}], [[~{~a~^,~}]]);" 
  		  pointlist edgelist))

(defun polyhedron (pointlist facelistlist)
  (format nil "polyhedron([~{[~{~,6f~^,~}]~^,~}], [~{[~{~a~^,~}]~^,~}]);" 
  		  pointlist facelistlist))

; DIY OpenSCAD commands

(defun emit (scad &key (file *STANDARD-OUTPUT*) (fn 20) (includes '()))
  (if (eq file *STANDARD-OUTPUT*)
	  (progn
		(format t "~{include <~a>;~}" includes)
		(format t "$fn=~a;" fn)
		(format t "~a" (merge-scad scad)))
	  (with-open-file (s file :direction :output :if-exists :supersede)
		(progn
		  (format s "~{include <~a>;~}" includes)
		  (format s "$fn=~a;" fn)
		  (format s "~a" (merge-scad scad)))))
  't)

(defun arc (radius from-angle to-angle)
  (let ((real-to-angle (if (> to-angle from-angle)
						   to-angle
						   (+ 360 to-angle))))
	(polygon
	 (append '((0 0))
			 (loop for a from from-angle upto real-to-angle collect
				  (list (* radius (cosd a)) (* radius (sind a))))
			 '((0 0)))
	(loop for p upto (+ (- real-to-angle from-angle) 2) collect p))))
	
(defun line-xyz (xyz1 xyz2 &optional (cutter "sphere(3)"))
  (format nil "hull() {
                 translate([~{~,6f~^,~}]) ~a;
		         translate([~{~,6f~^,~}]) ~a;
 	           }" xyz1 cutter xyz2 cutter))

(defun pairwise-line (lst &optional (cutter "sphere(3)"))
  (let ((lst1 lst)
		(lst2 (append (cdr lst) (list (car lst)))))
	(mapcar (lambda (p1 p2)
			  (scad:line-xyz p1 p2 cutter))
			lst1 lst2)))

; simulate a 3-axis milling machine. if you want to rotate your part,
; do that yourself between milling operations. also, add the first
; point again on the end to close the path. also also, the milling
; cutter isn't spinning, which is actually a feature not a bug. you
; can "drag" at cube through material and leave a sqrt(2) path if
; going diagonally. maybe "drag" would be a better name than "mill"...
(defun mill (pointlist &optional (cutter "sphere(3)")) 
  (mapcar (lambda (p1 p2) 
			(scad:line-xyz p1 p2 cutter))
		  pointlist (cdr pointlist)))

; machinery/helpers

(defun in->mm (inches)
  (* inches 25.4))

(defun cosd (degrees)
  (cos (* degrees (/ pi 180))))

(defun sind (degrees)
  (sin (* degrees (/ pi 180))))

(defun merge-scad (l)
  (if (listp l)
	  (reduce 
	   (lambda (a b) (concatenate 'string a b))
	   (mapcar #'merge-scad l))
	  l))

;; ; test cases
;; (emit
;;  (polyhedron '((0 0 0) (10 10 10) (10 -10 10)) '((0 1 2)))
;;  :file "/home/dr/software/blueprints/3D/openscad/sierpinski.scad")

;; (emit 
;;  (rotate 45 0 0 (cube 10 10 10))
;;  :file "/tmp/blah")

;; (emit 
;;  (cylinder 10 10)
;;  :file "/tmp/blah")

;; (emit
;;  (scale .5 .5 .5
;; 		(loop for i upto 3
;; 		   collecting (rotate (* i 120) 0 0 
;; 							  (translate 0 10 0 
;; 										 (cube 1 1 1)))))
;;  :file "/tmp/blah")

;; (emit
;;  (difference
;;   (translate -50 -50 -50 
;; 			 (cube 100 100 100))
;;   (let ((result '()))
;; 	(dotimes (i 50 (merge-scad result))
;; 	  (push (translate (- (random 100) 50) 
;; 					   (- (random 100) 50)
;; 					   (- (random 100) 50)
;; 					   (sphere 5))
;; 			result))))
;;  :file "/tmp/blah")

;; (emit 
;;  (difference
;;   (cylinder 50 60)
;;   (translate 10 0 -10 (cylinder 50 80)))
;;  :file "/tmp/blah")

;; (emit 
;;  (scad-union 
;;   (merge-scad (loop for i upto 30 collect
;; 				   (translate (random 50) 0 (random 50) 
;; 							  (sphere (random 5)))))
;;   (rotate 0 0 -60 (merge-scad (loop for i upto 30 collect
;; 								  (translate (random 50) 0 (random 50) 
;; 											 (sphere (random 5)))))))
;;  :file "/tmp/blah")

;; (emit 
;;  (difference
;;   (cylinder 50 60)
;;   (translate 0 0 -10 (linear-extrude 80 (arc 55 0 300)))
;;   (scad-union 
;;    (merge-scad (loop for i upto 50 collect
;; 					(translate (random 50) 0 (random 50) 
;; 							   (sphere (random 5)))))
;;    (rotate 0 0 -60 (merge-scad (loop for i upto 50 collect
;; 								   (translate (random 50) 0 (random 50) 
;; 											  (sphere (random 5))))))))
;;  :file "/tmp/blah")

;; (emit 
;; ; (scad-intersection (cube 1 1 1) (sphere .5))
;;  (scad-union (cube 5 5 5 :center 't) (sphere (* (sqrt 2) 2.5)))
;;  :file "/tmp/blah"
;;  :fn 200)

;; (emit
;;  (line-xyz '(0 0 0) '(10 10 10) 1)
;;  :file "/home/dr/software/blueprints/3D/openscad/sierpinski.scad"
;;  :includes '("coordinates.scad"))

;; (emit 
;;  (scad:mill '((0 0 0) (10 10 0) (10 20 0) (0 0 0)) (scad:sphere 3))
;;  :file "/tmp/blah")
