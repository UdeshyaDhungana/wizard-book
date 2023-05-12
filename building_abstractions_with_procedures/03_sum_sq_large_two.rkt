#lang racket

(define (sum-of-square a b) (+ (sqr a) (sqr b)))

(define (task a b c)
  (cond ((and (= (min a b) a) (= (min a c) a))  (sum-of-square b c))
        ((and (= (min b a) b) (= (min b c) b))  (sum-of-square c a))
        (else (sum-of-square a b))))

(task 1 2 3)
(task 4 5 0)

;; Alternative way. (works only for non negative)
(define (max-sos a b c)
  (let ((ab (sum-of-square a b))
        (bc (sum-of-square b c))
        (ac (sum-of-square a c)))
    (max ab bc ac)))

(max-sos 1 2 3)
(max-sos 4 5 0)
