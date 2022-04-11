#lang racket
;Compute give f(n)

(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))))

;Construct a table to see a pattern

(define (table max)
  (define (make-table start end)
    (cond ( (= start end) 0)
          (else 
            (display (f start))
            (display "\n")
            (make-table (+ start 1) end))))
  (make-table 1 max))

(table 10)
