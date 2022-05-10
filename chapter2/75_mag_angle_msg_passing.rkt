#lang racket
;; Message passing

(define (make-from-mag-angle r a)
  (define (dispatch op)
    (cond ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          (else (error "Unknown operation -- MAKE-FROM-MAG-ANGLE" op))))
  dispatch)

(define (apply-generic op arg)
  (arg op))
