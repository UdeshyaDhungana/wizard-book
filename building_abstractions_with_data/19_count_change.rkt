#lang racket
					;Change making using list

(define (count-change amount)
  (cc amount 5))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (no-more? l)
  (= (length l) 0))

(define (except-first-denomination l)
  (cdr l))

(define (first-denomination l)
  (car l))

(define nepal-coins (list 50 25 10 5 1))
(define nepal-coins-reverse (reverse (list 50 25 10 5 1) ))

(cc 100 nepal-coins)
(cc 100 nepal-coins-reverse)
;; No effect on changing orders
