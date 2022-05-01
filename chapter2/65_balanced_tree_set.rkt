#lang racket
;; Union and Intersection of sets in Θ(n)

(define (make-tree entry left right)
  (list entry left right))

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                ;; we exclude one element that would be the entry of the tree
                ;; so (n - (m + 1)) if m is the number of elements in left tree
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(define (tree->list tree)
  (if (null? tree)
      '()
      (let ((left-list (tree->list (left-branch tree)))
            (right-list (tree->list (right-branch tree))))
        (append left-list (cons (entry tree) right-list)))))

;; Given two ordered lists, produces the union of them
;; Takes Θ(n) time

(define (union-set a b)
  (define (union-seq a b)
    (cond ((null? a) b)
          ((null? b) a)
          (else (let ((x1 (car a))
                      (x2 (car b)))
                  (cond ((= x1 x2) (cons x1 (union-seq (cdr a) (cdr b))))
                        ((> x1 x2) (cons x2 (union-seq a (cdr b))))
                        (else (cons x1 (union-seq (cdr a) b))))))))
  (list->tree (union-seq (tree->list a) (tree->list b))))

(define (intersection-set set1 set2)
  (define (helper a b)
    (cond ((or (null? a) (null? b)) '())
          ((= (car a) (car b)) (cons (car a)
                                     (helper (cdr a) (cdr b))))
          ((< (car a) (car b)) (helper (cdr a) b))
          ((< (car b) (car a)) (helper a (cdr b)))))
  (helper (tree->list set1) (tree->list set2)))
