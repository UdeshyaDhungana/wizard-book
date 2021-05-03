
;; load 74.scm

(define (average x y)
  (/ (+ x y) 2))

(define (smooth stream)
  (cons-stream (average (stream-car stream)
			(stream-car (stream-cdr stream)))
	       (smooth (stream-cdr stream))))


(define (make-zero-crossings input-stream smooth)
  (let ((smoothed (smooth input-stream)))
    (stream-map sign-change-detector
		smoothed
		(cons-stream 0 smoothed))))
