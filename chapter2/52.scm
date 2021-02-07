
					;Modifications to the wave painter such that it has a smile now. Yay!

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
					;Things added are
(define q23 (make-vector 0.42 0.8))
(define q24 (make-vector 0.46 0.75))
(define q25 (make-vector 0.54 0.75))
(define q26 (make-vector 0.58 0.8))

;Only last four points are added
(define points (list q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20 q21 q22 q23 q24 q25 q26))

					;Lets make a list of segments from these points
(define (make-segment-list point-seq)
  (define (looper result source)
    (cond ((null? source) result)
	  ((= (cddr source) ()) (append result (list (make-segment (car source) q1))))
	  (else (append result (make-segment (car source) (cadr source)))))))

(define seg-list (make-segment-list points))

(define smile-painter (segments->painter seg-list))



					;Changing the corner-split procedure
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
	    (corner (corner-split painter (- n 1)))
          (beside (below painter up-split)
                  (below right-split corner-split))))))


					;Modifying Mr. Rogers' image to make him look away from the center

(define (square-limit painter n)
  (let ((combine4 (square-of-four identity flip-horiz
                                  flip-vert rotate180)))
    (combine4 (corner-split painter n))))
