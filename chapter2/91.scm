
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result
		     ;; sub-terms is defined in 88.scm
		     ;; mul-terms is provided in textbook
		     (div-terms (sub-terms L1
					   (mul-term-by-all-terms
					    (make-term new-o new-c)
					    L2))
				L2)))
		(list (adjoin-term (make-term new-o new-c)
				   (car rest-of-result))
		      (cadr rest-of-result))))))))

;; returns a list whose first element is the quotient
;; and second is the remainder
(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (let ((t1 (term-list p1))
	    (t2 (term-list p2)))
	;; car, because cadr is the remainder
	(let ((division (div-terms t1 t2)))
	  (list (make-poly (variable p1) (car division))
		(make-poly (variable p1) (cadr division)))))
      (error "different variable polynomials -- DIV-POLY"
	     (list p1 p2))))
