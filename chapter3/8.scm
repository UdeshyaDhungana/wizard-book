
;; Tomorrow

(define f
  (let ((expired 0))
    (lambda (x)
      (if (= expired 0)
	  (set! expired (+ expired 1)) x
	  0))))

;; function expires, i.e. returns 0 after first call,
;; returns x otherwise

;; Remember that this function can be implemented in many ways,
;; what matters is you make use of a local state variable
