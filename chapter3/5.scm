
;; Monte carlo simulation

;; Let, (random x) is a procedure that returns a non-negative number
;; less than x

;; this function returns a random number between low and high
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

;; higher order monte-carlo
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))


(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (lies-inside?)
    ;; Generate random pair
    ;; Test it with predicate
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (monte-carlo trials lies-inside?))


(define (estimate-pi)
  (/ (estimate-integral (lambda (x y)
		       (<= (+ (square (- x 5)) (square (- y 7))) 9))) 9))
