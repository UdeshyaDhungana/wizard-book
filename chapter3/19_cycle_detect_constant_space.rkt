#lang sicp

(define (atom? x)
  (not (pair? x)))

(define (has-cycle? x)
  (define (helper tortoise rabbit first-time?)
    (cond ((or (atom? rabbit)
               (null? rabbit)
               (not (pair? (cdr rabbit))))
           #f)
          ;; test equality
          ((and (eq? tortoise rabbit) (not first-time?)) #t)
          (else (helper (cdr tortoise) (cddr rabbit) #f))))
  (helper x x #t))

(define x (list 1 2 3 4 5))
(has-cycle? x)

(define y (cons 1 2))
(has-cycle? y)

(has-cycle? 'b)

(define a (cons 1 3))
(set-cdr! a a)
(has-cycle? a)
