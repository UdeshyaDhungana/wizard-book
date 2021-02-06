
;Product using higher order procedure

(define (product term a next b)
  (define (iter start accumulator)
    (if (> start b)
      accumulator
      (iter (next start) (* accumulator (term start)))))
  (iter a 1))

(define (factorial n)
  (define (identity x) x)
  (define (following x)(+ x 1))
  (product identity 1 following n))


(factorial 5)

;Estimation of pi/4

(define (quarter-pi-estimate n)
  (define (get-numerator x) (- (+ x 2.0) (remainder x 2)))
  (define (get-denominator x) (- (get-numerator (+ x 1.0)) 1.0))
  (define (pi-term x) (/ (get-numerator x) (get-denominator x)))
  (define (next-term x) (+ x 1))
  (product pi-term 1 next-term n))


(quarter-pi-estimate 100)
