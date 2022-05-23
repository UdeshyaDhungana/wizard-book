#lang racket

(require "../lib.rkt")

(define (tree-map action tree)
  (cond ((null? tree) '())
	((pair? tree) (cons (tree-map action (car tree)) (tree-map action (cdr tree))))
	(else (action tree))))


(define (square-tree tree)
  (tree-map square tree))
