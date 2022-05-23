#lang racket

(require "../lib.rkt")

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (sqr (car things))
                    answer))))
  (iter items '()))

					;Because for each element encountered in 'items', the square
					;of that element is added from the beginning of the list
(define (square-list-another items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (sqr (car things))))))
  (iter items '()))

;; Because to cons a data with a list, we need to add that data from
;; the beginning. So this is wrong
;; This can be better understood as
;; (cons 0 (list 1 2))
;; is different from
;; (cons (list 0 1) 2)
