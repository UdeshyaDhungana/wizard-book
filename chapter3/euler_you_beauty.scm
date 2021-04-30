
;; If Sn is the nth term of the original sequence then the accelerated sequence has terms

;; (- (Sn+1) (/ (square (- Sn+1 Sn)) (+ (Sn-1) (* -2 Sn) (Sn+1))))
;; Magical formula. Let's bring this to use

;; dependencies
(define (pi-summands n)
(cons-stream (/ 1.0 n)
	     (stream-map - (pi-summands (+ n 2)))))
(define pi-stream (scale-stream (partial-sums (pi-summands 1)) 4))

;; ========================================

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1))
	(s2 (stream-ref s 2)))
    (cons-stream  (- s2 (/ (square (- s2 s1))
                           (+ s0 (* -2 s1) s2)))
		  (euler-transform (stream-cdr s)))))

;; warning: infinite printing just for demonstration
(display-stream (euler-transform pi-stream))

;; lets accelerate an accelerated sequence

;; this is stream of streams
;; each successive stream is transform of the previous ones
;; it converges veryyyyy fast
(define (make-tableau transform s)
  (cons-stream s
	       (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))

;; warning again
(display-stream (accelerated-sequence euler-transform
                                      pi-stream))
