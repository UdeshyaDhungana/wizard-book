
(define (add-streams s1 s2)
(stream-map + s1 s2))

(define s (cons-stream 1 (add-streams s s)))

;; This generates a stream in the exponent of 2
