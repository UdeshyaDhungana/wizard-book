
;; please load 60.scm before this file

;; s is a series with first term 1
(define (invert-unit-series s)
  (define result (cons-stream 1 (scale-stream (mul-series (stream-cdr s) result) -1)))
  result)

;; to test this one

;; load exponential series
;; invert it
;; it should produce e^{-x}
