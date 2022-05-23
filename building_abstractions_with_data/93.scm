
;; inside rational package

(define (make-rat a b)
  (cons a b))

(define (add-rat x y)
  (make-rat (add (mul (numer x) (denom y))
               (mul (numer y) (denom x)))
            (mul (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (sub (mul (numer x) (denom y))
               (mul (numer y) (denom x)))
            (mul (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (mul (numer x) (numer y))
            (mul (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (mul (numer x) (denom y))
            (mul (denom x) (numer y))))


