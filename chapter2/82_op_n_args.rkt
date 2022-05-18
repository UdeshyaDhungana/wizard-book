#lang racket


(require "./generic_arith_cross_types.rkt")

(define (get-all-coercions base-type other-types)
  (map (lambda (x)
         (if (eq? base-type x)
             ;; return identiy function
             (lambda (u) u)
             (get-coercion x base-type)))
       other-types))

(define (contains-empty-list? seq)
  (cond ((null? seq) #f)
        ((eq? (car seq) '()) #t)
        (else (contains-empty-list? (cdr seq)))))

(define (apply-coercion-functions f args)
  (cond ((and (eq? f '()) (eq? args '())) '())
        (else (cons ((car f) (car args))
                     (apply-coercion-functions (cdr f) (cdr args))))))

(define (produce-coercion type-tags args)
  (define (helper tt)
    (if (eq? tt '())
        #f
        ;; no coercions possible
        (let ((coercion-functions (get-all-coercions (car tt) type-tags)))
          (if (contains-empty-list? coercion-functions)
              (helper (cdr tt))
              (apply-coercion-functions coercion-functions args)))))
  (helper type-tags))


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if (not (eq? proc '()))
          (apply proc (map contents args)) ;apply the process if it is found for same type
          (let ((coerced-arguments (produce-coercion type-tags args)))
            ;produce the list of coerced arguments
            (if coerced-arguments
                ;; get the type tags of coerced arguments, and then search for entry in table
                ;; all are of same type
                ;; get from dict
                ;; apply it
                (let ((coerced-type-tags (map type-tag coerced-arguments)))
                  (let ((applicable-function (get op coerced-type-tags)))
                    (apply applicable-function (map contents coerced-arguments))))
                (error "no method for these types -- APPLY-GENERIC" (list args type-tags))))))))


(put 'add '(complex complex complex) (lambda (z1 z2 z3)
                                       (make-complex-from-real-imag
                                        (+ (real-part z1) (real-part z2) (real-part z3))
                                        (+ (imag-part z1) (imag-part z2) (imag-part z3)))))


(define a (make-scheme-number 3))
(define b (make-scheme-number 4))
(define c (make-complex-from-real-imag 4 5))

(apply-generic 'add a b c)
;; This is fail whenever, let's say we have an operation on types
;; (a b b) and our arguments are of type (a b c), any coercion will not produce
;; (a b b) because all elements must be same type in coercion. So this will fail

;; Two argument will fail on any operation with 3 or more arguments+
