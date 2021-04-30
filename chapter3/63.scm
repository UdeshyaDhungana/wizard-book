
(define (sqrt-improve guess x)
  (/ (+ guess (/ x guess)) 2))

(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))

;; Louis' version has to compute, let's say 10th item from the start,
;; because it is not stored in local variable. it cannot take advantage
;; of memoization. So, Louis' version of the program is slow
