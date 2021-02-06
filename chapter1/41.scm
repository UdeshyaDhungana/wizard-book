
;Implementation of double procedure

(define (double f)
  (lambda (x)
    (f (f x))))

(define (inc x) (+ x 1))

(define inc-twice (double inc))

(inc-twice 2)

(((double (double double)) inc) 5)
