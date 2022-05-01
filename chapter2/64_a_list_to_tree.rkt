#lang racket
;; 2.64_a

(define (make-tree entry left right)
  (list entry left right))

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


;; Partial tree works in the following way
;; 1. First it determines the size of its left tree
;; 2. Then it extracts the left-result as left tree and the remaining elements
;; 3. Then it determines the size of its right tree
;; 4. It computes right-result as the partial tree of the elements from the cdr of the  non-left-elements
;; 5. Right tree is the car of this reuslt
;; 6. It makes tree from left tree, car of the non-left tree, and cdr of non-left tree(right tree)
;; 7. It conses the tree with the elements wihch are not included
