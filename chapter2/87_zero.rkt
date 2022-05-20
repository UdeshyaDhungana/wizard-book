
;; ----inside scheme number package

;; The =zero? procedure for different types are written in`80_zero.rkt`

;; ----inside polynomial package----

;; When is a polynomial zero?
;; When all its coefficients are zero

(define (=zero-poly? poly)
  (define (all-coeff-zero? termlist)
    (cond ((empty-termlist? termlist) true)
	  ((=zero? (first-item termlist))
	   (all-coeff-zero? (rest termlist)))
	  (else false)))
  (all-coeff-zero? (term-list poly)))

(put '=zero? 'polynomial =zero-poly?)
