
(define (runtime) (real-time-clock))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next n)
    (if (= n 2) 3 (+ n 2)))
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
                n
                (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(prime? 17)

(define (filtered-accumulate combiner null-value term a next b filter)
  (if (> a b)
    null-value
    (combiner (filtered-accumulate combiner null-value term (next a) next b filter) (if (filter a)
        (term a)
        null-value))))

(define (another x) (+ x 1))

;Sum of squares from 10 to 20 which are odd --------------> Number a
(filtered-accumulate + 0 square 10 another 20 prime?)

;--------------------------------------------------------------------
;Product of all the positive integers less than n that are relatively prime to n

(define n 10)

(define (test x) 
  (and (> x 0) (< x n) (= (gcd x n) 1)))

(filtered-accumulate * 1 (lambda (x) x) 1 another n test)
