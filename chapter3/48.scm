
(define (make-account-and-serializer id balance)
  (define (withdraw amount)
    (if (>= balance amount)
	(begin (set! balance (- balance amount))
	       balance)
	"Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'id) id)
	    ((eq? m 'withdraw) withdraw)
	    ((eq? m 'deposit) deposit)
	    ((eq? m 'balance) balance)
	    ((eq? m 'serializer) balance-serializer)
	    (else (error "Unknown request -- MAKE-ACCOUNT"
			 m))))
    dispatch))

(define (serialized-exchange account1 account2)
  (let* ((serializer1 (account1 'serializer))
	 (serializer2 (account2 'serializer))
	 (exchanger (if (< (account1 'id) (account2 'id))
			(serializer1 (serializer2 exchange))
			(serializer2 (serializer1 exchange)))))
    (exchanger account1 account2)))
