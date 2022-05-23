#lang racket
;This program implements make-rat for both positive and negative number

;; make rat
(define (make-rat n d)
  (let ((scale (if (< d 0)
			-1
			1)))
    (cons (* n scale) (* d scale))))

;; make numerator negative if rational is negative, leave denominator alone.
