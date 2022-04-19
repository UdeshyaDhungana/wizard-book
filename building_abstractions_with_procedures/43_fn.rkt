#lang racket
;N repeated application of f

(require "../lib.rkt")

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 1)
    f
    (compose f (repeated f (- n 1)))))


;; ((repeated square 2) 5) => 625

;; provide
(provide repeated)
