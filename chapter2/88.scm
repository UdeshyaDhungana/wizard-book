
;; subtraction of polynomial
;; ((2 3) (4 5))


;; inside polynomial package


(define (sub-poly p1 p2)
  (define (negate-terms tl)
    (cond ((empty-termlist? tl) tl)
	  ((adjoin-term (make-term (order (first-term tl))
				   (negate (coeff (first-term tl))))
			(negate-terms (rest tl))))))
  (define (sub-terms t1 t2)
    (add-terms t1 (negate-terms t2)))
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
		 (sub-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var -- SUB POLY"
	     (list p1 p2))))
