;; Calling the cops

(define (make-account balance password)
  (let ((incorrect-attempts 0))
    
    (define (withdraw amount)
      (if (>= balance amount)
	  (begin (set! balance (- balance amount))
		 balance)
	  "Insufficient funds"))

    (define (deposit amount)
      (set! balance (+ balance amount)))

    (define (incorrect amount)
      "Incorrect password")

    (define (call-the-cops amount)
      "Call the cops")

    ;; if incorrect-attempts = 7, and incorrect attempt is
    ;; encountered, call the cops
    (define (dispatch passwd op)
      (if (eq? passwd password)
	  (cond ((eq? op 'withdraw) withdraw)
		((eq? op 'deposit) deposit)
		(else "Invalid operation -- MAKE-ACCOUNT"
		      op))
	  (if (>= incorrect-attempts 7)
	      call-the-cops
	      (begin (set! incorrect-attempts (+ 1 incorrect-attempts))
		     incorrect))))
    dispatch))
