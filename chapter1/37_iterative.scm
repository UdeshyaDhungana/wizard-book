
;Infinite continued fraction using iterative process

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
      result
      (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(define (id x) 1.0)

(cont-frac id id 20)
