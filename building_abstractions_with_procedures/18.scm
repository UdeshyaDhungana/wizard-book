
;Fast multiplication


(define (double x) (* 2 x))
(define (halve x) (/ x 2))

(define (product a b)
  (define (fp a b result)
    (cond 
      ((= a 0) result)
      ((even? a) (fp (halve a) (double b) result))
      (else (fp (- a 1) b (+ result b)))))

  (fp a b 0)
  )


(product 10 7)
