
;; integral-starting-from

(define (integral delayed-integrand initial-value dt)
  (let ((integrand (force delayed-integrand)))
    (cons-stream initial-value
		 (if (stream-null? integrand)
		     '()
		     (integral (stream-cdr integrand)
			       (+ (* dt (stream-car integrand))
				  initial-value)
			       dt)))))
