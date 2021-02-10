
;; lookup procedure when set of records is structured as a
;; binary tree

;; Let each node is represented as ((key . value) left-tree right-tree)

(define (make-tree key value left-tree right-tree)
  (list (cons key value) left-tree right-tree))

(define (left-tree tree)
  (cadr tree))

(define (right-tree tree)
  (caddr tree))

(define (entry tree)
  (car tree))

(define (key record)
  (car record))

(define (value record)
  (cdr record))

(define (lookup given-key tree-of-records)
  (cond ((null? tree-of-records) #f)
	((= given-key (key (entry tree-of-records))) (value (entry tree-of-records)))
	((< given-key (key (entry tree-of-records))) (lookup given-key (left-tree tree-of-records)))
	((> given-key (key (entry tree-of-records))) (lookup given-key (right-tree tree-of-records)))))
