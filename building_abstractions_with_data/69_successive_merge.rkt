#lang racket
;; generate-huffman-tree

(require "huffman.rkt")

;; Other dependency functions

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; Pairs are given as ((A 4) (B 2) (C 1) (D 1))

(define (successive-merge list-of-leaves)
  (cond ((null? list-of-leaves) '())	;Length = 0
        ;; last element;; this is the remaining tree
        ((null? (cdr list-of-leaves)) (car list-of-leaves)) ;Length = 1
        (else (successive-merge (adjoin-set (make-code-tree (car list-of-leaves)
                                                            (cadr list-of-leaves))
                                            (cddr list-of-leaves))))))

;; It works as intended!
;; Explanation: If length is 0, we return empty list
;; If the length is 1, we return the only element of the list
;; else, we make a new tree from first two leaves/tree(since it's an ordered set, these two will be the
;; ones with lowest weight, adjoin it to the list from third element (to preserve ordered set), and we
;; run successive-merge on that set

(provide generate-huffman-tree)
