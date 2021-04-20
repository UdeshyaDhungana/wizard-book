
(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
	(if (< (get-value b) 0)
	    (error "square less than 0 -- SQUARER" (get-value b))
	    ;; if b has a valid value
	    (set-value! a
			(sqrt (get-value b))
			me))
	(if (has-value? a)
	    (set-value! b
			(square (get-value a))
			me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'i-have-a-value)
	   (process-new-value))
	  ((eq? request 'i-lost-my-value)
	   (process-new-value))
	  (else
	   (error "Unknown request -- SQUARER" request))))
  (connect a me)
  (connect b me))