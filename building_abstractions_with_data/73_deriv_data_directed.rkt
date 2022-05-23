#lang racket

;; a) Because number and variable do not have operators to be dispatched,
;; they're implemented as simple racket atoms

;; b)

;; table implementation
(define *op-table* (make-hash))
(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))
(define (get op type)
  (hash-ref *op-table* (list op type) '()))

;; answers
(define (attach-tag type content)
  (cons type content))

(define (install-sum-package)
  (define (make-sum a b)
    (list a b))
  (define (addend s)
    (car s))
  (define (augend s)
    (cadr s))
  (define (deriv-sum s var)
    (tag (make-sum (deriv (addend s) var) (deriv (augend s) var))))

  ;; interface
  (define (tag x) (attach-tag '+ x))
  (put 'deriv '(+) deriv-sum)
  (put 'make-sum '+ (lambda (x y)
                      (tag (make-sum x y))))
  'sum-package-install:done!)

(install-sum-package)

(define (make-sum x y)
  ((get 'make-sum '+) x y))


(define (install-product-package)
  (define (make-product p q)
    (list p q))
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))

  (define (deriv-product p var)
    (make-sum (tag (make-product (multiplier p)
                            (deriv (multiplicand p) var)))
              (tag (make-product (multiplicand p)
                            (deriv (multiplier p) var)))))

  ;; interface to the rest of the system
  (define (tag x) (attach-tag '* x))
  (put 'deriv '(*) deriv-product)
  (put 'make-product '*
       (lambda (x y)
         (tag (make-product x y))))

  'product-package-install:done!)

(install-product-package)

(define (make-product x y)
  ((get 'make-product '*) x y))

;; generic

(define (variable? x) (symbol? x))
(define (same-variable? a b)
  (and (variable? a) (variable? b) (eq? a b)))

(define (deriv expression var)
  (cond ((number? expression) 0)
        ((variable? expression) (if (same-variable? expression var) 1 0))
        (else ((get 'deriv (list (operator expression))) (operands expression)
                                           var))))

(define (operator expression) (car expression))
(define (operands expression) (cdr expression))


;; c) Implementation of exponential

(define (install-exponential-package)
  (define (make-exponential base power)
    (list base power))
  (define (base expression)
    (car expression))
  (define (power expression)
    (cadr expression))
  (define (tag x) (attach-tag 'exponent x))

  (define (deriv-exp term var)
    (make-product (power term)
                  (make-product (tag (make-exponential (base term)
                                                       (- (power term) 1)))
                                (deriv (base term) var))))
  (put 'deriv '(exponent) deriv-exp)
  (put 'make-exponential 'exponent (lambda (b p)
                                (tag (make-exponential b p))))
  'exponential-package-install:done)

(install-exponential-package)

(define (make-exponential base power)
  ((get 'make-exponential 'exponent) base power))


;; d. We should change the order of arguments in put respectively. That's all we need to do!
