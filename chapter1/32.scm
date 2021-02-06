
;Even higher order procedure for sum/product kinda thingy

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (accumulate combiner null-value term (next a) next b) (term a))))


(define (next x) (+ x 1))

;This gives product of square of terms from 1 to 4
(accumulate * 1 square 1 next 4)

;This gives sum of square of terms from 1 to 4
(accumulate + 0 square 1 next 4)

;Hence, sum/product can be constructed from even higher level procedures
