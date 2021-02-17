
;; Making of accumulator

(define (make-accumulator initial)
  (lambda (argument)
    (set! initial (+ initial argument))
    initial))
