#lang sicp
;; Explaining the queue

;; List interpreter does not know how to print a queue
;; So it prints it as it sees.
;; For example a queue `1, 2, 3` is actually, in our representation
;; a pair, whose first element points to the car of the list (1 2 3)
;; and whose cdr points to the last pair of the given list.
;; Hence a queue `1, 2, 3` is seen on lisp evaluator as
;; ((1 2 3) 3)

;; Definition of print-queue:
;; It is inside `queue.scm`
