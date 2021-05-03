
;; WARNING: DEFINE `sense-data` FIRST

(define (sign-change-detector current previous)
  (if (> (/ current previous) 0)
      0
      (if (> current 0)
	  1
	  -1)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
			(stream-car input-stream))))

(define zero-crossings (make-zero-crossings sense-data 0))

;; it is equivalent to following

(define zero-crossings-boss
  (stream-map sign-change-detector
	      sense-data
	      (cons-stream (stream-car sense-data)
			   (stream-cdr sense-data))))
