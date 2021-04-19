
;; or gate from and and not (easy peasy)


;; Here we apply De-Morgan's Law
(define (or-gate x y output)
  (let ((xbar (make-wire))
	(ybar (make-wire))
	(obar (make-wire)))
    (inverter x xbar)
    (inverter y ybar)
    (and-gate xbar ybar obar)
    (inverter obar output)
    'ok))

;; The dealy of this gate is 2*inverter_delay + and_gate_delay
