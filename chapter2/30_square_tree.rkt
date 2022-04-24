#lang racket

(require "../lib.rkt")

(define (square-tree tree)
  (map (lambda (sub-tree)
	 (if (pair? sub-tree)
	     (square-tree sub-tree)
	     (* sub-tree sub-tree)))
       tree))

;Without higher level function
(define (square-self tree)
  (cond ((null? tree) '())
	((pair? tree) (cons (square-self (car tree)) (square-self (cdr tree))))
	(else (square tree))))
