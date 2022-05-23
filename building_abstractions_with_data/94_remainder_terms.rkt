

;; inside polynomial package
(define (remainder-terms l1 l2)
  (cadr (div-terms l1 l2)))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (gcd-poly p1 p2)
  (if (same-variable? (variable p1)
                      (variable p2))
      (make-poly (variable p1)
                 (gcd-terms (term-list p1)
                            (term-list p2)))
      (erorr "different variable polynomials -- GCD-POLY"
             (list p1 p2))))

(put 'greatest-common-divisor '(polynomial polynomial) gcd-poly)
(put 'greatest-common-divisor '(scheme-number scheme-number) gcd)

(define (greatest-common-divisor a b)
  (apply-generic 'greatest-common-divisor a b))

;; --------- TESTS ---------

(define p1 (make-poly 'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '((3 1) (1 -1))))
(greatest-common-divisor p1 p2)
;; = (make-poly 'x (gcd terms (term-list p1) (term-list p2)))
;; = lets ignore outer part and focus solely on gcd of terms
;; a = ((4 1) (3 -1) (2 -2) (1 2))
;; b = ((3 1) (1 -1))
;; = (gcd-terms b (remainder-terms a b))
;; = (gcd-terms b (cadr (div-terms a b)))
;; = (gcd-terms b (cadr ((1 1) (0 -1)) ((2 -1) (1 1))))
;; = (gcd-terms ((3 1) (1 -1)) ((2 -1) (1 1)))
;; = (gcd-terms ((2 -1) (1 1)) (remainder-terms ((3 1) (1 -1)) ((2 -1) (1 1))))
;; = (gcd-terms ((2 -1) (1 1)) '())
;; = ((2 -1) (1 1))
;; = -x² + x
