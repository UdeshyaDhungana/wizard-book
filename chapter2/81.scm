
;; a. For an operation whose enry is not found in the table,
;; apply-generic will coerce the first argument to second, i.e.
;; for example we've called the function exp with two complex numbers,
;; then, it'll coerce the first argument to complex, and again call the
;; apply-generic function. This will result in an infinite loop.

;; b. Louis tried to do good thing but in a wrong way. Something has to be
;; done to avoid coercion of same type

;; c. This can be overcome by changing apply-generic as follows

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
	  (apply proc (map contents args))
	  (if (= 2 (length args))
	      (let ((type1 (car type-tags))
		    (type2 (cadr type-tags))
		    (a1 (car args))
		    (a2 (cadr args)))
		(if (eq? type1 type2)
		    (error "same type coercion is not possible -- APPLY-GENERIC"
			   type1)
		    (let ((t1->t2 (get-coercion type1 type2))
			  (t2->t1 (get-coercion type2 type1)))
		      (cond (t1->t2
			     (apply-generic op (t1->t2 a1) a2))
			    (t2->t1
			     (apply-generic op (t2->t1 a2) a1))
			    (else
			     (error "No method for these types"
				    (list op type-tags))))))
		(erorr "No method for these types"
		       (list op type-tags))))))))

