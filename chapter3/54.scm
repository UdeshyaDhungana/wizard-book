
;; dependencies
(define (add-streams s1 s2)
  (stream-map + s1 s2))
(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))

;; Mul streams
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

;; factorials
(define factorials (cons-stream 1 (mul-streams (stream-cdr integers) factorials)))
