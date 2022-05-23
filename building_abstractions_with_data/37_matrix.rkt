#lang racket

(require "../lib.rkt")

(define (dot-product u v)
  (accumulate + 0 (map * u v)))

(define (matrix-*-vector m v)
  (map (lambda (x)
         (dot-product x v)) m))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x)
           (matrix-*-vector cols x)) m)))
