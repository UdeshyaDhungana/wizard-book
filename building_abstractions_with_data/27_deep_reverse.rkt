#lang racket


(define (deep-reverse l)
  (define (iter item result)
    (if (null? item)
        result
        ;If list? reverse on itself, else
        (iter (cdr item) (cons (if (list? (car item))
                                   (reverse (car item))
                                   (car item)) result))))
  (iter l '()))
