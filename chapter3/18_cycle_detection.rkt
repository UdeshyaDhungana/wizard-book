#lang sicp
;; A procedure that determines whether a list contains a

(define (has-cycle? x)
  (let ((visited '()))
    (define (helper x)
      (cond ((not (pair? x)) 0)
            ((memq x visited) 1)
            (else (begin (set! visited (cons x visited))
                         (helper (cdr x))))))
    (helper x)))

(define x '(2 . 3))
(set-cdr! x x)
(has-cycle? x)

;; Detects a cycle for a list, not for a tree

;; Logic: keep track of visited nodes
;; if current node is not a pair, it cannot contain a cycle
;; else, keep current node in visited list, and cdr down the list


;; Remember, the book asks us to detect a cycle in a list, not a list structure!
