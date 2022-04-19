#lang racket
					;Second representation of rectangle

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-rect top-left bottom-right)
  (cons top-left bottom-right))

(define (top-left rect) (car rect))
(define (bottom-right rect) (cdr rect))

(define (get-height rect)
  (- (y-point (top-left rect)) (y-point (bottom-right rect))))

(define (get-width rect)
  (- (x-point (bottom-right rect)) (y-point (top-left rect))))

(define start (make-point 2 3))
(define end (make-point 5 0))

(define my-rect (make-rect start end))

;; same procedures as in representation1

(define (get-area rect)
  (* (get-height rect) (get-width rect)))

(define (get-perimeter rect)
  (* 2 (+ (get-height rect) (get-width rect))))

(get-area my-rect)
(get-perimeter my-rect)
