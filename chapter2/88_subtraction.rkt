
(define (negate x)
  (apply-generic 'negate x))

;; inside scheme-number package
(define (neg-scheme-number n)
  (* -1 n))
(put 'negate '(scheme-number) neg-scheme-number)


;; inside rational package
(define (neg-rational x)
  (make-rational (* -1 (numer x)) (denom x)))
(put 'negate '(rational) neg-rational)

;; inside rectangular number package
(define (neg-rectangular x)
  (make-complex-from-real-imag (* -1 (real-part x))
                               (* -1 (imag-part x))))
(put 'negate '(rectangular) neg-rectangular)

(define (neg-polar x)
  (make-complex-from-mag-ang (magnitude x)
                             (+ pi (angle x))))
(put 'negate '(polar) neg-polar)

(define (neg-complex x)
  (apply-generic 'negate x))
(put 'negate '(complex) neg-complex)

;; inside polynomial package

;; function to negate terms
(define (negate-terms tl)
  (cond ((empty-termlist? tl) tl)
        ((adjoin-term (make-term (order (first-term tl))
                                 (negate (coeff (first-term tl))))
                      (negate-terms (rest tl))))))

(define (neg-poly x)
  (make-poly (variable x)
             (negate-terms x)))

(define (sub-poly p1 p2)
  (define (sub-terms t1 t2)
    (add-terms t1 (negate-terms t2)))
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (sub-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var -- SUB POLY"
             (list p1 p2))))

(put 'negate '(polynomial) neg-poly)
(put 'sub '(polynomial polynomial) sub-poly)
