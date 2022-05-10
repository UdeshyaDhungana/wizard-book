;; DON'T LOAD THIS FILE; CONATINS MULTIPLE DEFINITIONS OF SAME NAME FUNCTIONS
;; Complex number representations

(make-from-real-imag (real-part z) (imag-part z))

(make-from-mag-angle (magnitude z) (angle z))

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


;; Imagine, Ben is working on rectangular representation. His part would be

(define (real-part z) (car z))
(define (imag-part z) (cdr z))

(define (magnitude z)
  (sqrt (+ (square (real-part z)) (square (imag-part z)))))
(define (angle z)
  (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y) (cons x y))
(define (make-from-mag-ang r a)
  (cons (* r (cos a)) (* r (sin a))))

;; Alyssa uses polar representation. Her part would be

(define (real-part z)
  (* (magnitude z) (cos (angle z))))
(define (imag-part z)
  (* (magnitude z) (sin (angle z))))

(define (magnitude z) (car z))
(define (angle z) (cdr z))

(define (make-from-real-imag x y)
  (cons (sqrt (+ (square x) (square y)))
        (atan y x)))
(define (make-from-mag-ang r a) (cons r a))

;; According to data abstraction, add complex, sub, mul and div complex will work
;; We can choose EITHER Ben's representation or that Alyssa

;; Our system works very well, but we have a small problem. We cannot distinguish
;; the coordinate system of our complex numbers, and we cannot choose to work on both
;; representations

;; For example, if we wanted to know whether a pair (3 5) is in polar or cartesian form,
;; it's not possible to do so directly

;; INTRODUCTION TO TYPE TAGS

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z)
  (eq? (type-tag z) 'polar))

;; After introducting this, both Ben and Alyssa need to make a few changes to their code
;; They need to specify 'rectangular or 'polar when they've constructed a complex number.
;; Morever, function names should not conflict between each other, so they'll have to
;; append -rectangular or -polar in each of their function name to make them distinct.

;; The improved code is in complex_improved.scm
