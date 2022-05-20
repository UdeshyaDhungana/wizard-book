

(define p1 (make-poly 'x ((2 1) (1 -2) (0 1))))

(define p2 (make-poly 'x ((2 11) (0 7))))

(define p3 (make-poly 'x ((1 13) (0 5))))

(define q1 (mul-poly p1 p2))
(define q2 (mul-poly p1 p3))

(greatest-common-divisor q1 q2)
;; Doing it by hand,

;; After two pages long calculation on notebook, I found the gcd to be
;; (1458/169)x²-(2916/169)x+(1458/169)

;; It's not same as p1
;; Notice that the coefficient is a non integer, we can eliminate this by
;; multiplying dividend by a factor such that no fractional coefficients
;; will arise.
;; That factor is C^(1+O₁-O₂), where C is the Leading coefficient of Q,
;; O₁ is the order of P, and O₂ is the order of Q.
;; If we multiply P by the given factor, we can divide it by Q without introducing
;; any fractions

;; Dividing this way is called pseudodivision, and the remainder obtained is called
;; pseudoremainder



;; explore pseudo remainder
