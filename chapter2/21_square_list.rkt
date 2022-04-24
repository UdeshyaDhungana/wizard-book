#lang racket

(require "../lib.rkt")

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items)) (map proc (cdr items)))))

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list (cdr items)))))


(define (square-list-map items)
  (map (lambda (x) (* x x)) items))
