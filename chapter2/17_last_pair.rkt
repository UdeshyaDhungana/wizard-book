#lang racket
					;Last pair implementation

;; (define (last-pair l)
;;   (if (<= (length l) 1)
;;       l
;;       (last-pair (cdr l))))

;; with primitives
(define (last-pair l)
  (if (or (null? l) (null? (cdr l)))
      l
      (last-pair (cdr l))))
