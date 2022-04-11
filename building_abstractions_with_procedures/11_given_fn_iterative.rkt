#lang racket

;; f(n) using iterative algorithm
(define (function count)
  (define (iterator a b c count)
    (if (< count 3)
      a
      (iterator (+ a (* 2 b) (* 3 c)) a b (- count 1))))
  (if (< count 3)
    count
    (iterator 2 1 0 count)))

(define (table max)
  (define (make-table start end)
    (cond ( (= start end) 0)
          (else 
            (display (function start))
            (display "\n")
            (make-table (+ start 1) end))))
  (make-table 1 max))

(table 10)
