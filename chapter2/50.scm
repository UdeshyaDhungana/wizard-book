
					;Flip horizonal painter

(define (transform-painter painter origin corner1 corner2)
  (lambda (painter)
    (let ((mapper (frame-coord-map frame)))
      (let ((new-origin (mapper origin)))
	(painter new-origin
		 (sub-vect (mapper corner1) new-origin)
		 (sub-vect (mapper corner2) new-origin))))))

(define (flip-horiz painter)
  (transform-painter painter (make-vector 1 0) (make-vector 0 0) (make-vector 1 1)))

(define (rotate180 painter)
  (transform-painter painter (make-vector 1 1) (make-vector 0 1) (make-vector 1 0)))

(define (rotate270-counterclockwise painter)
  (transform-painter painter (make-vector 0 1) (make-vector 0 0) (make-vector 1 1)))
