#lang racket
;Implementation of compositon of functions

(require "../lib.rkt")

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (inc x) (+ x 1))

((compose square inc) 6)
