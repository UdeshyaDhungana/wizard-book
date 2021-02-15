
;; Remember, selectors and operations are
;; (make-poly variable term-list)
;; (variable poly)
;; (term-list poly)
;; (add-poly p1 p2)
;; (mul-poly p1 p2)
;; the-empty-termlist => '()
;; (adjoin-term term termlist)
;; (empty-termlist? termlist)
;; (rest termlist)
;; (first-item termlist)
;; (order term)
;; (coeff term)
;; (make-term order coefficient)


;; =zero? procedure for polynomials in arithmetic package

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


;; ----inside polynomial package----
