
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

					;the collection of points
(define q1 (make-vector 0.4 1.0))
(define q2 (make-vector 0.35 0.95))
(define q3 (make-vector 0.4 0.7))
(define q4 (make-vector 0.3 0.7))
(define q5 (make-vector 0.2 0.6))
(define q6 (make-vector 0.0 0.8))
(define q7 (make-vector 0.0 0.6))
(define q8 (make-vector 0.2 0.35))
(define q9 (make-vector 0.3 0.6))
(define q10 (make-vector 0.4 0.4))
(define q11 (make-vector 0.2 0))
(define q12 (make-vector 0.3 0))
(define q13 (make-vector 0.5 0.4))
(define q14 (make-vector 0.6 0))
(define q15 (make-vector 0.7 0))
(define q16 (make-vector 0.6 0.5))
(define q17 (make-vector 1.0 0.2))
(define q18 (make-vector 1.0 0.5))
(define q19 (make-vector 0.7 0.7))
(define q20 (make-vector 0.6 0.7))
(define q21 (make-vector 0.65 0.95))
(define q22 (make-vector 0.6 1))

(define points (list q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20 q21 q22))

					;Lets make a list of segments from these points
(define (make-segment-list point-seq)
  (define (looper result source)
    (cond ((null? source) result)
	  ((= (cddr source) ()) (append result (list (make-segment (car source) q1))))
	  (else (append result (make-segment (car source) (cadr source)))))))

(define seg-list (make-segment-list points))

(define smile-painter (segments->painter seg-list))
