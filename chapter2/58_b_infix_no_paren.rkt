#lang racket

;; works perfectly as far as i can tell 🥳

;; import the other file
(require "../lib.rkt")

(define precedence-table
  (list (cons 'maxop 1000)
        (cons '+ 1)
        (cons '* 2)))

;; get the precedence value of operation from the precedence table
(define (get-precedence-value op)
  (define (iter table)
    ;; if operation is not in the list, ie maybe a number or bracket
    (cond ((null? table) (get-precedence-value 'maxop))
          ((eq? (caar table) op) (cdar table))
          (else (iter (cdr table)))))
  (iter precedence-table))

;; operator with lowest precedence
(define (lowest-op expr)
  (accumulate (lambda (current till-now)
                (if (< (get-precedence-value current)
                       (get-precedence-value till-now))
                    current
                    till-now))
              'maxop
              expr))

(define (variable? x) (symbol? x))

(define (same-variable? x y)
  (and (variable? x) (variable? y) (eq? x y)))

(define (sum? e)
  (eq? (lowest-op e) '+))

(define (extract-if-one e)
  (if (= 1 (length e)) (car e) e))

;; return augend of e, given e is a sum expression
(define (augend e)
  (define (iter e)
    (if (eq? (car e) '+)
        '()
        (cons (car e) (augend (cdr e)))))
  (extract-if-one (iter e)))

;; return addend of e
(define (addend e)
  (if (eq? (car e) '+)
      (extract-if-one (cdr e))
      (addend (cdr e))))

;; make-sum somehow
;; copy the same from previous
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2) (+ a1 a2)))
        (else (list a1 '+ a2))))

(define (product? e)
  (eq? (lowest-op e) '*))

;; pre (product? e) => t
(define (multiplier e)
  (define (iter e)
    (if (eq? (car e) '*)
        '()
        (cons (car e) (multiplier (cdr e)))))
  (extract-if-one (iter e)))

;; pre (product? e) => t
(define (multiplicand e)
  (if (eq? (car e) '*)
      (extract-if-one (cdr e))
      (multiplicand (cdr e))))

(define (make-product p1 p2)
  (cond ((or (=number? p1 0) (=number? p2 0)) 0)
        ((=number? p1 1) p2)
        ((=number? p2 1) p1)
        ((and (number? p1) (number? p2)) (* p1 p2))
        (else (list p1 '* p2))))

(define (deriv expressn var)
  (cond ((number? expressn) 0)
        ((variable? expressn)
         (if (same-variable? expressn var) 1 0))
        ((sum? expressn)
         (make-sum (deriv (augend expressn) var)
                   (deriv (addend expressn) var)))
        ((product? expressn)
         (make-sum (make-product (multiplier expressn)
                                 (deriv (multiplicand expressn) var))
                   (make-product (deriv (multiplier expressn) var)
                                 (multiplicand expressn))))
        (else (error "unknown expressnression type: DERIV" expressn))))
