#lang sicp

(define (last-pair seq)
  (if (null? (cdr seq))
      seq
      (last-pair (cdr seq))))


(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

;; response of (cdr x)

(define w (append! x y))
;; response of (cdr x) again


;; Answer:

;; First response is (b)
;; Second response is (b c d)