#lang racket
;NOTE: Load the `nested_mappings.scm` before this file

(require "../lib.rkt")

(define (make-pair-sum x)
  (list (car x) (cadr x) (+ (car x) (cadr x))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (unique-pairs n)
  (flatmap (lambda (i)
                (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
              (enumerate-interval 1 n)))

(define (prime-sum-pairs-mine num)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs num))))
