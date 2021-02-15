
;; Zero testing operator for generic type

(define (=zero? x) (apply-generic '=zero? x))


(define (install-scheme-number-package)
  ;; interface
  (put '=zero? '(scheme-number) zero?)
  'done)

(define (install-rational-package)
  ;; internal procedure
  (define (=zero? z)
    (zero? (numer z)))
  ;; interface
  (put '=zero? '(rational) =zero?)
  'done)

(define (install-rectangular-package)
  ;; internal procedure
  (define (=zero? z)
    (and (zero? (real-part z) (zero? (imag-part z)))))

  ;; interface
  (put '=zero? '(rectangular) =zero?)
  
  'done)

(define (install-polar-package)
  ;; internal procedure
  (define (=zero? z)
    (= 0 (magnitude z)))

  ;; interface
  (put '=zero? '(polar) =zero?)
  
  'done)

(define (install-complex-package)
  ;; internal procedure
  (put '=zero? '(complex) =zero?)
  
  'done)
