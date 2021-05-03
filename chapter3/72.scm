
;; please load all stream dependencies
;; load 70.scm

(define (stream-producer-of-sum-of-squares)
  (define (weight x)
    (+ (square (car x)) (square (cadr x))))
  (define (helper stream)
    (if (= (weight (stream-car stream))
	   (weight (stream-car (stream-cdr stream)))
	   (weight (stream-car (stream-cdr (stream-cdr stream)))))
	(cons-stream (weight (stream-car stream))
		     (helper (stream-cdr (stream-cdr (stream-cdr stream)))))
	(helper (stream-cdr stream))))
  (let ((sorted (weighted-pairs integers
				integers
				weight)))
    (helper sorted)))

(define result (stream-producer-of-sum-of-squares))

;; Value: {325 425 650 725 845 850 ...}
