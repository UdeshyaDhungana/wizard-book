#lang racket
;; Software testing application

(define (make-monitored f)
  (let ((counter 0))
    (lambda (z)
      (cond ((eq? z 'how-many-calls?) counter)
            (else (begin (set! counter (+ counter 1))
                         (f z)))))))


(define s (make-monitored sqrt))

(s 100)

(s 'how-many-calls?)


(s 361)

(s 'how-many-calls?)
