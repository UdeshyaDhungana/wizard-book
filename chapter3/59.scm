
(define (scale-stream stream factor)
  (cons-stream (* (stream-car stream) factor) (scale-stream (stream-cdr stream) factor)))

(define (integrate-series s)
  (define (adjust-coefficient s c)
    (cons-stream (/ (stream-car s) c) (adjust-coefficient (stream-cdr s) (+ c 1))))
  (adjust-coefficient s 1))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

;; Defining sine and cosine

;; cosine is the negative of the integral of sine series
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

;; sine is the integral of cosine
(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
