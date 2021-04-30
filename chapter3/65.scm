
;; Approximating ln 2 using three methods given in the text

;; ln2 = 1 - (1/2) + (1/3) - (1/4) ...

(define (ln-summands n)
  (cons-stream (/ 1.0 n)
	       (stream-map - (ln-summands (1+ n)))))

(define ln2-stream
  (partial-sums (ln-summands 1)))

;; let's accelerate this one

;; ========================================
(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
	(s1 (stream-ref s 1))
	(s2 (stream-ref s 2)))
    (cons-stream  (- s2 (/ (square (- s2 s1))
                           (+ s0 (* -2 s1) s2)))
		  (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
	       (make-tableau transform (transform s))))

;; we form a sequence by taking first term in each row of tableau
(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))
;; ========================================

(define transformed-ln2-stream (euler-transform ln2-stream))

(define fastest-ln2-stream (accelerated-sequence
			    euler-transform
			    ln2-stream))





