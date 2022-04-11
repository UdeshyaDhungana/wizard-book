#lang racket

;; Some useful functions not available in default racket
(define (square x) (* x x))

(define (cube x) (* x x x))

;; exports
(provide square)
(provide cube)
