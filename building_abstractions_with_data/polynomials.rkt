#lang racket

(require "./generic_arith_cross_types.rkt")

(define (add x y) (apply-generic 'add x y))
(define (mul x y) (apply-generic 'mul x y))

(define (=zero? x)
  (and (number? x) (= x 0)))

(require "./generic_arith_cross_types.rkt")

(define (install-polynomial-package)
  ;;internal procedures
  ;; represenetation of poly
  (define (make-poly variables term-list) (cons variables term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))
  (define (same-variable? x y) (and (symbol? x)
                                    (symbol? y)
                                    (eq? x y)))
  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1) (term-list p2)))
        (error "Polynomials not in same variable -- ADD-POLY" (list p1 p2))))


  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1) (term-list p2)))
        (error "Polynomials not in same variable -- MUL-POLY" (list p1 p2))))

  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  'polynomial-package-installed)

(install-polynomial-package)


(define (add-terms l1 l2)
  (cond ((empty-termlist? l1) l2)
        ((empty-termlist? l2) l1)
        (else
         (let ((t1 (first-term l1))
               (t2 (first-term l2)))
           (cond ((> (order t1) (order t2))
                  (adjoin-term
                   ;; use of add-terms is very powerful
                   t1 (add-terms (rest-terms l1) l2)))
                 ((< (order t1) (order t2))
                  (adjoin-term
                   t2 (add-terms l1 (rest-terms l2))))
                 (else
                  (adjoin-term
                   (make-term (order t1)
                              (add (coeff t1) (coeff t2)))
                   (add-terms (rest-terms l1)
                              (rest-terms l2)))))))))

(define (mul-terms l1 l2)
  (if (empty-termlist? l1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term l1) l2)
                 (mul-terms (rest-terms l1) l2))))


(define (mul-term-by-all-terms t1 l)
  (if (empty-termlist? l)
      (the-empty-termlist)
      (let ((t2 (first-term l)))
        (adjoin-term
         (make-term (+ (order t1) (order t2))
                    (mul (coeff t1) (coeff t2)))
         (mul-term-by-all-terms t1 (rest-terms l))))))


(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

(define (the-empty-termlist) '())

(define (first-term term-list)
  (car term-list))

(define (rest-terms term-list)
  (cdr term-list))

(define (empty-termlist? term-list)
  (null? term-list))

(define (make-term order coeff)
  (list order coeff))

(define (order term)
  (car term))

(define (coeff term)
  (cadr term))

(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))

;; (define a (make-polynomial 'x (list (make-term 2 (make-scheme-number 3))
;;                                                      (make-term 1 (make-scheme-number 4))
;;                                                      (make-term 0 (make-scheme-number 7)))))
;;
;; (define b (make-polynomial 'x (list (make-term 2 (make-scheme-number 9))
;;                                                      (make-term 1 (make-scheme-number 6))
;;                                                      (make-term 0 (make-scheme-number 8)))))
;;
;; (add a b)
