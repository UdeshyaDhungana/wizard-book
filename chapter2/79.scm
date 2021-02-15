
;; Equality operator for different packages

(define (equ? x y) (apply-generic 'equ? x y))


(define (install-scheme-number-package)
  ;; internal procedure
  (define (equ? a b)
    (= a b))

  ;; interface
  (put 'equ? '(scheme-number scheme-number)
       equ?)
  'done)

(define (install-complex-package)
  ;; internal procedures
  (define (equ? z w)
    (and (= (real-part z) (real-part w))
	 (= (imag-part z) (imag-part w))))
  ;; I could have dispatched this further down to rectangular and polar types
  ;; but, angle may differ by a multiple of 2Π, so it works for now :)
  
  ;; interface
  (put 'equ? '(complex complex) equ?)
  'done)


(define (install-rational-package)
  ;; internal procedure
  (define (equ? r s)
    (and (= (numer r) (numer s))
	 (= (denom r) (denom s))))

  ;; interfacing procedure
  (put 'equ? '(rational rational) equ?)
  'done)


