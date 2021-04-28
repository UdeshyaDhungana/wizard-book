
;; partials sums of given stream

(define (partial-sums s)
  (define result (cons-stream (stream-car s) (add-streams (stream-cdr s) result)))
  result)

;; really elegent
