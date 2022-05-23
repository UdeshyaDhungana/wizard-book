#lang racket
;; Tomorrow

(define f
  (let ((calls 0))
    (lambda (arg)
      (if (= calls 0)
          arg
          (begin (set! calls 1)
                 0)))))


;; function expires, i.e. returns 0 after first call,
;; returns x otherwise

;; Remember that this function can be implemented in many ways,
;; what matters is you make use of a local state variable
