#lang racket
;; Making of accumulator

(define (make-accumulator initial)
  (lambda (argument)
    (set! initial (+ initial argument))
    initial))

(define a (make-accumulator 0))

(a 10)
(a 20)
(a 30)
