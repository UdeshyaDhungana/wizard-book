#lang racket

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))


(define (adjoin-set x set)
  (cond ((null? set) (list x '() '()))
        ((= (entry set) x) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(provide entry
         left-branch
         right-branch
         make-tree
         element-of-set?
         adjoin-set)

;Actual exercise

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      ;; total cost is the cost to convert left branch
      ;; conversion of right branch
      ;; append a list
      ;; assume cons takes constant time
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))


;Let's see how do the results differ

(define tree (make-tree 7 (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '())) (make-tree 9 '() (make-tree 11 '() '()))))
(define another (make-tree 3 (make-tree 1 '() '()) (make-tree 7 (make-tree 5 '() '()) (make-tree 9 '() (make-tree 11 '() '())))))
(define yet (make-tree 5 (make-tree 3 (make-tree 1 '() '()) '()) (make-tree 9 (make-tree 7 '() '()) (make-tree 11 '() '()))))

;So far, I cannot see any differences between the two results

;; Solution to part b

;; On algorithm 1

;; T(n) = 2 * T(n/2) + O(n/2) is the equation for algorithm 1
;; append takes O(n/2) on average
;;        ·For both       ·For append
;; On solving this, we get T(n) = O(n * log(n))


;; On algorithm 2

;; T(n) = 2 * T(n/2) + Θ(1)
;; It takes Θ(n) time
;;       ·For both    ·Consing
