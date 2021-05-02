
;; import all stream dependencies and 70.scm

(define (ramanujan-stream)
  (define (stream-cadr x)
    (stream-car (stream-cdr x)))
  (define (stream-cddr x)
    (stream-cdr (stream-cdr x)))
  (define (weight x)
    (+ (cube (car x)) (cube (cadr x))))
  (define (helper stream)
    (if (= (weight (stream-car stream))
	   (weight (stream-cadr stream)))
	(cons-stream (weight (stream-car stream))
		     (helper (stream-cddr stream)))
	(helper (stream-cdr stream))))
  (let ((sorted (weighted-pairs integers
			       integers
			       weight)))
    (helper sorted)))

(define result (ramanujan-stream))
(stream-ref result 5)

;; Value: {1729 4104 13832 20683 32832 39312}
