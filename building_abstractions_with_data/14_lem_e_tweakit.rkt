#lang racket
;Demonstration program

(define (make-interval a b)
  (if (> a b)
    (cons b a)
    (cons a b)))

;Exercise
(define (lower interval) (car interval))
(define (upper interval) (cdr interval))

					;Arithmetic functions
;From book
(define (add-interval x y)
  (make-interval (+ (lower x) (lower y))
                 (+ (upper x) (upper y))))

(define (pos? x)
  (>= x 0))

(define (neg? x)
  (< x 0))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower i) (upper i)) 2))

(define (width i)
  (/ (- (upper i) (lower i)) 2))

					;Percentage tolerance implementation

(define (make-center-percentage mid percent)
  (make-center-width mid (* percent 0.01 mid)))

(define (percent i)
  (* (/ (width i) (center i)) 100))

					;Approx multiplication function
(define (mul-interval a b)
  (make-center-percentage (* (center a) (center b)) (+ (percent a) (percent b))))

(define (reciprocal interval)
  (make-interval (/ 1.0 (upper interval))
                 (/ 1.0 (lower interval))))


(define (div-interval x y)
  (mul-interval x (reciprocal y)))

					;Test the results

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1))) 
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))


					;Mistake can be verified by doing
(define r1 (make-center-percentage 100 3))
(define r2 (make-center-percentage 100 3))
(par1 r1 r2)
(par2 r1 r2)
					;The results are differnet

