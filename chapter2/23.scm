					;For each implementation

(define (for-each proc items)
  (cond ((not (null? items))
	 (proc (car items))
	 (for-each proc (cdr items)))))
