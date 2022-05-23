#lang racket

(require "../lib.rkt")

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-left / 1 (list 1 2 3)) ;Yields 1/6
(accumulate / 1 (list 1 2 3)) ;Yields 3/2


(accumulate list '() (list 1 2 3)) ;Yields (list 1 (list 2 (list 3 ())))
(fold-left list '() (list 1 2 3)) ;Yields (list (list (list () 1) 2) 3)

					;Explanation is pretty simple,
					;accumulate applies the operation to first element and result of accmulating on rest of the sequence
					;fold-left applies operation on result and first element and pushes it to the left side for next eval

					;Answer: Commutative law must be satisfied to yield the same answer by both
					;Example

(accumulate * 1 (list 1 2 3))
(fold-left * 1 (list 1 2 3))

(accumulate + 0 (list 1 2 3))
(fold-left + 0 (list 1 2 3))

					;And I was again wrong, both associative law and commutative law must be satisfied because

 (fold-left append '(5)  (list '(1) '(2 3) '() '(4)))  ;; (5 1 2 3 4) 
 (fold-left append '(5) (list '(1) '(2 3) '() '(4)))  ;; (1 2 3 4 5)
