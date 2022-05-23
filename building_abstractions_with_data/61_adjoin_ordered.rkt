#lang racket
;As ordered list

(define (adjoin-set x given-set)
  (cond ((null? given-set) (list x))
		((= x (car given-set)) given-set)
		((< x (car given-set)) (cons x given-set))
		(else (cons (car given-set) (adjoin-set x (cdr given-set))))))
