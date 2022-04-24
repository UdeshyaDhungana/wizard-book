#lang racket

;; Some useful functions not available in default racket

;; Prime checking module
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next n)
    (if (= n 2) 3 (+ n 2)))
  (cond ((> (sqr test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))


;; average
(define (average x . y)
  (define (iter sequence result l)
    (if (null? sequence)
        result
        (iter (cdr sequence) (/ (+ (car sequence) (* result (- l 1.0))) l) (+ l 1))))
  (iter (cons x y) 0.0 1))

;; accumulate
(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      ;; operate -> car -> acc rest
      ;; combine first element of sequence with result of combining all the right elements
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))
(define fold-right accumulate)


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

;; fold left: accumulate, but in reverse order
(define (fold-left op initial sequence)
  (define (iter result remaining)
    (if (null? rest)
        result
        ;; apply result to car of the rest
        (iter (op result (car remaining))
              (cdr rest))))
  (iter initial sequence))

;; enumerate interval inclusive
(define (enumerate-interval start end)
  (if (> start end)
      '()
      (cons start (enumerate-interval (+ 1 start) end))))

;; flatmap
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

;; exports
(provide smallest-divisor)
(provide divides?)
(provide prime?)
(provide average)
(provide accumulate)
(provide accumulate-n)
(provide fold-right)
(provide fold-left)
(provide enumerate-interval)
