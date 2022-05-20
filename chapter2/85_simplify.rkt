#lang racket

(define *op-table* (make-hash))

(provide put)
(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(provide get)
(define (get op type)
  (hash-ref *op-table* (list op type) '()))

(provide attach-tag)
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(provide type-tag)
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(provide contents)
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-rectangular-package)
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (magnitude z)
    (sqrt (+ (sqr (real-part z))
             (sqr (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-real-imag x y) (cons x y))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
(install-rectangular-package)


(define (install-polar-package)
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-mag-angle r a) (cons r a))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (sqr x) (sqr y)))
          (atan y x)))
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) magnitude)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-angle r a))))
  'done)
(install-polar-package)

(provide real-part)
(define (real-part z) (apply-generic 'real-part z))
(provide imag-part)
(define (imag-part z) (apply-generic 'imag-part z))
(provide magnitude)
(define (magnitude z) (apply-generic 'magnitude z))
(provide angle)
(define (angle z) (apply-generic 'angle z))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; generic procedures
;; don't make these available
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (raise x) (apply-generic 'raise x))
(define (project x) (apply-generic 'project x))

(define (drop x)
  (if (or (not (pair? x))
          (eq? (type-tag x) 'integer)
          (not (equ? x (raise (project x)))))
      x
      (drop (project x))))


(define (install-integer-package)
  (define (tag x)
    (attach-tag 'integer x))
  (put 'add '(integer integer)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(integer integer)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(integer integer)
       (lambda (x y) (tag (* x y))))
  (put 'div '(integer integer)
       (lambda (x y)
             (make-rational x y)))
  (put 'equ? '(integer integer)
       (lambda (x y)
         (= x y)))
  ;; raise: integer -> real
  (put 'raise '(integer)
       (lambda (x) (make-real x)))
  (put 'make 'integer
       (lambda (x)
         (if (integer? x)
             (tag x)
             (error "Not an integer" (list x))))))
(install-integer-package)

(provide make-integer)
(define (make-integer x)
  ((get 'make 'integer) x))


(define (install-rational-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (if (= d 0)
        (error "Cannot make rational with denominator 0 -- " (list n d))
        (let ((g (gcd n d)))
          (cons (/ n g) (/ d g)))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'equ? '(rational rational)
       (lambda (x y) (= (* (numer x) (denom y))
                        (* (denom x) (numer y)))))
  ;; raise: rational -> real
  (put 'raise '(rational)
       (lambda (x) (make-real (/ (numer x) (denom x)))))
  (put 'project '(rational)
       (lambda (x) (make-integer (numer x))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)
(install-rational-package)

(provide make-rational)
(define (make-rational n d)
  ((get 'make 'rational) n d))


(define (install-real-package)
  (define (tag x)
    (attach-tag 'real x))
  (put 'add '(real real)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(real real)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(real real)
       (lambda (x y) (tag (* x y))))
  (put 'div '(real real)
       (lambda (x y) (tag (/ x y))))
  (put 'equ? '(real real)
       (lambda (x y) (= x y)))
  (put 'make 'real
       (lambda (x) (tag x)))
  ;; raise: real->complex
  (put 'raise '(real)
       (lambda (x) (make-complex-from-real-imag x 0)))
  (put 'project '(real)
       (lambda (x) (make-integer (round x))))
  'done)
(install-real-package)

(define (make-real n)
  ((get 'make 'real) n))


(define (install-complex-package)
  ;; (hash-keys *op-table*)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'equ? '(complex complex)
       (lambda (z1 z2) (and (= (real-part z1)
                                  (real-part z2))
                            (= (imag-part z1)
                                  (imag-part z2)))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  (put 'project '(complex)
       (lambda (z)
         (display "Now commencing")
         (make-real (real-part z))))
  'done)
(install-complex-package)

(provide make-complex-from-real-imag)
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(provide make-complex-from-mag-ang)
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))


(put 'equ? '(rational real)
     (lambda (x z)
       (equ? (raise x) z)))
(put 'equ? '(real rational)
     (lambda (z x)
       (equ? z (raise x))))


;; cross type operations

(define *coercion-table* (make-hash))

(provide put-coercion)
(define (put-coercion type-1 type-2 func)
  (hash-set! *coercion-table* (list type-1 type-2) func))

(provide get-coercion)
(define (get-coercion type-1 type-2)
  (hash-ref *coercion-table* (list type-1 type-2) '()))

;; this is the tower
(define tower '(integer rational real complex))
(define special-operations '(project raise))

(define (which-lower-type? type1 type2)
  (let ((type1memq (memq type1 tower))
        (type2memq (memq type2 tower)))
    (if (and type1memq type2memq)
        (if (> (length type1memq) (length type2memq))
            type1
            type2)
        (error "One or more type not found in tower" (list type1 type2)))))


;; apply generic is modified to take advantage of raise
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    ;; get procedure for the types
    (let ((proc (get op type-tags)))
      (if (not (eq? proc '()))
          (if (memq op special-operations)
              (apply proc (map contents args))
              (drop (apply proc (map contents args))))
          ;; if length of args is 2, we do this, else error
          (if (= (length args) 2)
              ;; get types, and arguments
              (let ((type-1 (car type-tags))
                    (type-2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((lower-type (which-lower-type? type-1 type-2) ))
                  (if (eq? lower-type type-1)
                      (apply-generic op (raise a1) a2)
                      (apply-generic op a2 (raise a2)))))
              (error "No method for these types" (list op args)))))))


(define a (make-complex-from-real-imag 4 0))
(drop a)

(define x (make-complex-from-real-imag 4 4))
(define y (make-complex-from-real-imag 4 -4))
(add x y)
