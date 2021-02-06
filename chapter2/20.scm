					;Same parity checker
(define (same-parity init . tail)
  (define (generator source destination)
    (if (null? source)
	destination
	(if (even? (+ init (car source)))
	    (generator (cdr source) (append destination (list (car source))))
	    (generator (cdr source) destination))))
  (generator tail (list init)))


					;I consider this a better version than the one above

(define (smae-parity first . rest)
  (define (generator source)
    (if (null? source)
	()
	(if (even? (+ first (car source)))
	    (cons (car source) (generator (cdr source)))
	    (generator (cdr source)))))
  (generator (cons first rest)))
