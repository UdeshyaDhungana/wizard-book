#lang racket

(define (make-vect x y)
  ;; list not cons, coz we may go in 3d
  (list x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cadr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))


(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))


(define (scale-vect scalar v)
  (make-vect (* scalar (xcor-vect v)) (* scalar (ycor-vect v))))

;; export
(provide make-vect
         xcor-vect
         ycor-vect
         add-vect
         sub-vect
         scale-vect)
