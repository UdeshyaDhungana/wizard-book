#lang racket

(require sicp-pict)
(require "../lib.rkt")

(define q1 (make-vect 0.4 1.0))
(define q2 (make-vect 0.35 0.95))
(define q3 (make-vect 0.4 0.7))
(define q4 (make-vect 0.3 0.7))
(define q5 (make-vect 0.2 0.6))
(define q6 (make-vect 0.0 0.8))
(define q7 (make-vect 0.0 0.6))
(define q8 (make-vect 0.2 0.35))
(define q9 (make-vect 0.3 0.6))
(define q10 (make-vect 0.4 0.4))
(define q11 (make-vect 0.2 0))
(define q12 (make-vect 0.3 0))
(define q13 (make-vect 0.5 0.4))
(define q14 (make-vect 0.6 0))
(define q15 (make-vect 0.7 0))
(define q16 (make-vect 0.6 0.5))
(define q17 (make-vect 1.0 0.2))
(define q18 (make-vect 1.0 0.5))
(define q19 (make-vect 0.7 0.7))
(define q20 (make-vect 0.6 0.7))
(define q21 (make-vect 0.65 0.95))
(define q22 (make-vect 0.6 1))
;Things added are
(define q23 (make-vect 0.42 0.8))
(define q24 (make-vect 0.46 0.75))
(define q25 (make-vect 0.54 0.75))
(define q26 (make-vect 0.58 0.8))

;Only last four points are added
(define outer-body (list q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20 q21 q22))
(define smile (list q23 q24 q25 q26))
(define whole (list outer-body smile))

;Lets make a list of segments from these points
(define (make-segment-list point-seq)
  (if (null? (cdr point-seq))
      '()
      (cons (make-segment (car point-seq) (cadr point-seq))
            (make-segment-list (cdr point-seq)))))

(define (multiple-strokes list-of-point-seq)
  (flatmap (lambda (x)
             (make-segment-list x))
           list-of-point-seq))

(define seg-list (multiple-strokes whole))

(define smile-painter (segments->painter seg-list))

(paint smile-painter)
