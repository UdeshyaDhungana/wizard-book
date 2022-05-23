#lang racket
					;Multiplication with small percentage tolerance
					;Program to implement make-center-width

(define (make-interval a b)
  (if (> a b)
    (cons b a)
    (cons a b)))


(define (lower interval) (car interval))
(define (upper interval) (cdr interval))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower i) (upper i)) 2))

(define (width i)
  (/ (- (upper i) (lower i)) 2))


(define (make-center-percentage mid percent)
  (make-center-width mid (* percent 0.01 mid)))

(define (percent i)
  (* (/ (width i) (center i)) 100))

					;Multiplication part
(define (approx-mul a b)
  (make-center-percentage (* (center a) (center b)) (+ (percent a) (percent b))))
