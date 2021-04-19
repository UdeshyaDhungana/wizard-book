
;; ripple carry adder

;; a and b should be lists of bits
(define (ripple-carry-adder al bl sl cin)
  (if (not (null? al))
      (let ((carry (make-wire)))
	(full-adder (car al) (car bl) cin (car sl) carry)
	(ripple-carry-adder (cdr al) (cdr bl) (cdr sl) carry))))


