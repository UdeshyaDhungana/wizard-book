#lang racket
;Rectangle Implementation

(require racket/provide)

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

;Give it the coordinate of top left corner of rectangle
(define (make-rect start height width)
  (cons start (cons height width)))

(define (get-height rect)
  (car (cdr rect)))

(define (get-width rect)
  (cdr (cdr rect)))


(define (get-area rect)
  (* (get-height rect) (get-width rect)))

(define (get-perimeter rect)
  (* 2 (+ (get-height rect) (get-width rect))))


(define corner (make-point 1 5))
(define myrect (make-rect corner 3 2))

(get-area myrect)
(get-perimeter myrect)

(provide get-area)
(provide get-perimeter)
