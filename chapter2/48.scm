
					;Implementation of segment
(load "46.scm")

(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car segment))

(define (end-segment seg)
  (cdr segment))


