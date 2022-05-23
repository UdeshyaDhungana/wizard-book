#lang racket
;Finding all ordered triplets less than n such that they sum pu to give the number s

(require "../lib.rkt")

;; all ordered pair (i j) such that i and j are distinct and <= n
(define (ordered-pair n)
  (filter (lambda(tuple)
            ;; filter out null ones
            (not (null? tuple)))
          (flatmap (lambda (i)
                     (map (lambda (j)
                            (if (= i j)
                                ;; empty if i and j are equal
                                '()
                                ;; otherwise a list
                                (list i j)))
                          ;; prepare a pair (i j) for every possible j, i.e 1 to n
                          (enumerate-interval 1 n)))
                   ;; for each num from 1 to n
                   (enumerate-interval 1 n))))

;; all triplets (i j k) each unique number less than n
(define (triplets n)
  (define (in i pair)
    (if (null? pair)
        #f
        (or (= i (car pair)) (in i (cdr pair)))))
  (filter (lambda(tuple)
            ;;filter out null ones
            (not (null? tuple)))
          (flatmap (lambda (i)
                     (map (lambda (pair)
                            (if (in i pair)
                                ;; if repeated, null
                                '()
                                ;; else valid pair
                                (cons i pair)))
                          ;; prepare a distinct ordered pair (i j) such that i <= n and j <= n
                          (ordered-pair n)))
                   ;; for every number from 1 to n
                   (enumerate-interval 1 n))))

(define (sum-to-s n s)
  ;; filter in the ones from triplets whose sum is equal to s
  (filter (lambda(tup)
            (= s (accumulate + 0 tup)))
          (triplets n)))
