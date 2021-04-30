
;; stream-limit procedure

(define (stream-limit s tolerance)
  (let ((first (stream-car s))
	(second (stream-car (stream-cdr s))))
    (if (< (abs (- second first)) tolerance)
	second
	(stream-limit (stream-cdr s) tolerance))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
