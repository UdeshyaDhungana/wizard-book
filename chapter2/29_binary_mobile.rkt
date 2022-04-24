#lang racket
;Binary mobile

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  ;; change to cdr for cons implementation2
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  ;; change to cdr for cons implementation2
  (cadr branch))

(define (leaf? branch)
  (number? (branch-structure branch)))

(define (total-w mobile)
  (define (branch-weight branch)
    (if (leaf? branch)
        (branch-structure branch)
        (total-w (branch-structure branch))))
  (+ (branch-weight (left-branch mobile)) (branch-weight (right-branch mobile))))

(define (torque branch)
  (* (branch-length branch) (if (leaf? branch)
                                 (branch-structure branch)
                                 (total-w (branch-structure branch)))))

(define (balanced? mobile)
  (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
       (if (not (leaf? (left-branch mobile)))
           (balanced? (branch-structure (left-branch mobile)))
           #t)
       (if (not (leaf? (right-branch mobile)))
           (balanced? (branch-structure (right-branch mobile)))
           #t)))


;; implementation2
(define (make-mobile2 left right) (cons left right))
(define (make-branch2 length structure) (cons length structure))

;; I'd only have to change `right-branch` and `branch-structure` procedures to
;; (define (right-branch branch) (cdr branch))
;; (define (branch-structure branch) (cdr branch))
