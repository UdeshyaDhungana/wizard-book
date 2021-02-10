
;; generate-huffman-tree

(load "huffman")

;; Other dependency functions

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; Pairs are given as ((A 4) (B 2) (C 1) (D 1))

(define (successive-merge list-of-leaves)
  (cond ((null? list-of-leaves) '())	;Length = 0
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
