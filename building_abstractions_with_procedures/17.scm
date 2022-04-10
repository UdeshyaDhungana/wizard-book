;Fast multiplication

(define (double x) (* 2 x))
(define (halve x) (/ x 2))


(define (product a b)
    (cond 
      ((= a 0) 0)
      ((even? a) (product (halve a) (double b)))
      (else (+ b (product (- a 1) b))))))


(product 3 0)
(product 10 7)
