
					;Implementing a few painters
(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))


(define origin (make-vector 0 0))
(define i-hat (make-vector 1 0))
(define j-hat (make-vector 0 1))
(define corner (make-vector 1 1))

					;A painter that draws the outline of the designated frame using 'segements->painter'

(define seg1 (make-segment origin i-hat))
(define seg2 (make-segment i-hat corner))
(define seg3 (make-segment corner j-hat))
(define seg4 (make-segment j-hat origin))
(define (all-segs (list seg1 seg2 seg3 seg4)))

(define outline-painter (segements->painter all-segs))

					;The painter that draws an X

(define (diag1 (make-segment j-hat i-hat)))
(define (diag2 (make-segment origin corner)))

(define (x-painter (segements->painter (list diag1 diag2))))

					;The painter that draws a diamond shape by connecting midpoint of outlines

;Returns a vector to the midpoint of given segment
(define (midpoint segment)
  (make-vector (scale-vector 0.5 (add-vect (start-segment end-segment)))))

(define (p1 (midpoint seg1)))
(define (p2 (midpoint seg2)))
(define (p3 (midpoint seg3)))
(define (p4 (midpoint seg4)))

(define s1 (make-segment p1 p2))
(define s2 (make-segment p2 p3))
(define s3 (make-segment p3 p4))
(define s4 (make-segment p4 p1))

(define diamond-painter (segements->painter (list s1 s2 s3 s4)))

					;The wave painter
					;TODO
