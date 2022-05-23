#lang racket

(define (subsets a)
  (if (null? a)
      '(())
      (let ((remaining (subsets (cdr a))))
        (append remaining (map (lambda (el)
                            (cons (car a) el)) remaining)))))
