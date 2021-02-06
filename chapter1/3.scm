(define (sum-of-square a b) (+ (square a) (square b)) )

(define (minimum a b)
  (if (> a b) b a)
)

(define (task a b c)
  (cond ((and (minimum a b) (min a c))  (sum-of-square b c))
        ((and (minimum b a) (min b c))  (sum-of-square c a))
        (else ( sum-of-square a b ))
  )
)

(task 1 2 3)
(task 4 5 0)
