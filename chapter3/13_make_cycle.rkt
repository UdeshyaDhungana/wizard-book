#lang sicp


(define (last-pair seq)
  (if (null? (cdr seq))
      seq
      (last-pair (cdr seq))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c)))

;; Box pointer diagram fuck it; do it in your notebook



(last-pair z);;  will be stuck in an infinite loop
