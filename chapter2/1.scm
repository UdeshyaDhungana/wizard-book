					;This program implements make-rat for both positive and negative number

(define (make-rat n d)
  (let ((scale (if (< d 0)
			-1
			1)))
    (cons (* n scale) (* d scale))))
