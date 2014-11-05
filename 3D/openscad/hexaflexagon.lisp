(load "~/software/blueprints/3D/openscad/opensexp.lisp")
(load "~/software/blueprints/3D/openscad/360hinge.lisp")

;; connectors
;; (scad:emit
;;  (scad:scad-union
;;   (loop for i from 0 to 4 collecting
;; 	 (loop for j from 0 to 1 collecting
;; 		  (scad:translate (* j 2 *hinge-embed*) (* i 1.1 *thickness*) 0 (scad:rotate 90 0 0 (hinge 't))))))
;;  :file "/home/dr/software/blueprints/3D/openscad/hexaflexagon.scad"
;;  :fn 20)

;; ;; triangles
;; (scad:emit
;;  (scad:scad-union
;;   (loop for i from 0 to 0 collecting
;; 	 (loop for j from 0 to 1 collecting
;; 		  (scad:translate (* i 2 *center-to-corner*) (* j 1.3 *side-length*) 0 (hinged-triangle '(0 1))))))
;;  :file "/home/dr/software/blueprints/3D/openscad/hexaflexagon.scad"
;;  :fn 20)


;; Local Variables:
;; eval: (slime-eval-on-save)
;; End:
