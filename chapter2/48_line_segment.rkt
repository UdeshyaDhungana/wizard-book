#lang racket

(require "./46_vector.rkt")

(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(provide make-segment
         start-segment
         end-segment)


(define a (make-vect 1 2))
(define b (make-vect 3 4))
(define c (make-segment a b))
(start-segment c)
(end-segment c)
(xcor-vect (start-segment c))
(ycor-vect (end-segment c))
