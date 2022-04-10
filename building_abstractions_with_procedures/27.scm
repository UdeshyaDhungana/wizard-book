
;Demonstration of Carmichael's numbers: Fermat's pseudoprimes

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))

  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


(fast-prime? 2821 2820)
(fast-prime? 2465 2464)
(fast-prime? 1729 1728)
(fast-prime? 1105 1104)
(fast-prime? 561 560)
