#lang racket

(require sicp-pict)

(define p1 (make-vect 0 0.5))
(define p2 (make-vect 0.5 0))
(define p3 (make-vect 0.5 1))
(define p4 (make-vect 1 0.5))

(define s1 (make-segment p1 p3))
(define s2 (make-segment p3 p4))
(define s3 (make-segment p4 p2))
(define s4 (make-segment p2 p1))

(define diamond-painter (segments->painter (list s1 s2 s3 s4)))

(paint diamond-painter)
