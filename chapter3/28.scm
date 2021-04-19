
;; or gate as primitive function box

(define (or-gate i1 i2 output)

  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal i1) (get-signal i2))))
      (after-delay or-gate-delay
		   (lambda()
		     (set-signal! output new-value)))))
  (add-action! i1 or-action-procedure)
  (add-action! i2 or-action-procedure)
  'ok)

(define (logical-or a b)
  (cond ((and (= a 0) (= b 0)) 0)
	((and (or (= a 0) (= a 1)) (or (= b 0) (= b 1))) 1)
	(else "INVALID SIGNAL -- LOGICAL-OR" a b)))
