
;; Software testing application

(define (make-monitored f)
  (let ((counter 0))
    (lambda (z)
      (cond ((eq? z 'how-many-calls?) counter)
	    (else (begin (set! counter (+ counter 1))
			 (f z)))))))
