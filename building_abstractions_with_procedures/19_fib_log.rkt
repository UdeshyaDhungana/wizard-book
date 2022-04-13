#lang racket
;Fibonacci in exponential step

(require "../lib.rkt")

(define (sum-of-square a b)
  (+ (square a) (square b)))

(define (fib n)
  (define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count) (fib-iter a
                                   b
                                   (sum-of-square p q)
                                   (+ (* 2 p q) (square q)) (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p)) (+ (* b p) (* a q)) p q (- count 1)))))
  (fib-iter 1 0 0 1 n))


(define (showlog count)
  (if (< count 0)
      (display 'done)
      (begin (display (fib count))
             (display "\n")
             (showlog (- count 1)))))

(showlog 20)

(display (fib 100))
(display 'udeshya)
