#lang racket
;; Procedure 'reverse' using accumulate (fold-right) and fold-left

;; Dependencies
(require "../lib.rkt")


(define (reverse-fold-right sequence)
  (fold-right (lambda (first result) (append result (list first)))
              '()
              sequence))

(define (reverse-fold-left sequence)
  (fold-left (lambda (result first) (cons first result))
             '()
             sequence))
