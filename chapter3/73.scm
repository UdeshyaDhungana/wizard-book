
;; RC circuit simulation using streams

;; given integrand, initial value and interval
;; this procedure calculates stream that represents
;; integral of given integrand

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
		 (add-streams integrand
			      (scale-stream integrand dt))))
  int)

(define (rc resistance capacitance dt)
  (lambda (current initial-voltage)
    (add-streams (scale-stream current resistance)
		 (integral (scale-stream current (/ 1.0 capacitance))
			   initial-voltage
			   dt))))
