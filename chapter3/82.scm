

;; from text
(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) passed failed)))
  ;; if 1 add passed, if 0 add failed
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (estimate-integral p x1 x2 y1 y2)
  ;; generate random number each between a1 and b1; a2 and b2
    (define (random-number-pairs a1 a2 b1 b2) 
    (cons-stream (cons (random-in-range a1 a2) (random-in-range b1 b2)) 
		 (random-number-pairs a1 a2 b1 b2)))
    
    (define (random-in-range low high) 
    (let ((range (- high low))) 
      (+ low (* (random) range))))
    ;; calculate area of rectangle
    (let ((area (* (- x2 x1) (- y2 y1)))
	  ;; generat a stream of random pairs
	  (randoms (random-number-pairs x1 x2 y1 y2)))
      ;; subject that stream to monte carlo, and scale that stream to area
    (scale-stream (monte-carlo (stream-map p randoms) 0 0) area)))
