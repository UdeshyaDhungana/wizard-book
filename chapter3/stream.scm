

;; With ordinary lists, both the car and the cdr are evaluated at
;; construction time. With streams, the cdr is evaluated at selection
;; time.

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
	((pred (stream-car stream))
	 (cons-stream (stream-car stream)
		      (stream-filter pred (stream-cdr stream))))
	(else (stream-filter pred (stream-cdr stream)))))

;; ========================================

;; Delay and force are implemented as

;; (delay <exp>) => (lambda() <exp>)
;; (force <exp>) => (<exp>)


;; mandatory for experiments
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))
