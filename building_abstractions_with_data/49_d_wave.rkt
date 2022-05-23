#lang racket

(require sicp-pict)

(define q1 (make-vect 0.45 1.0))
(define q2 (make-vect 0.40 0.9))
(define q3 (make-vect 0.45 0.8))
(define q4 (make-vect 0.3 0.6))
(define q5 (make-vect 0.0 0.8))
(define q6 (make-vect 0.0 0.7))
(define q7 (make-vect 0.3 0.4))
(define q8 (make-vect 0.45 0.6))
(define q9 (make-vect 0.45 0.3))
(define q10 (make-vect 0.3 0))
(define q11 (make-vect 0.4 0))
(define q12 (make-vect 0.5 0.2))
(define q13 (make-vect 0.6 0))
(define q14 (make-vect 0.7 0))
(define q15 (make-vect 0.55 0.3))
(define q16 (make-vect 0.55 0.6))
(define q17 (make-vect 1.0 0.2))
(define q18 (make-vect 1.0 0.3))
(define q19 (make-vect 0.55 0.8))
(define q20 (make-vect 0.6 0.9))
(define q21 (make-vect 0.55 1.0))

(define points (list q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20 q21))

;; produce list of segment from list of points
(define (produce-los lop)
  (define (iter lop result)
    (if (null? (cdr lop))
        result
        (iter (cdr lop)
              (cons (make-segment (car lop) (cadr lop))
                    result))))
  (iter lop '()))

;Lets make a list of segments from these points

(define smile-painter (segments->painter (produce-los points)))

(paint smile-painter)
