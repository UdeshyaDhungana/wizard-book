
;; please load 60.scm and 61.scm before this file

;; divides series a by series b
(define (div-series a b)
  (if (= 0 (stream-car b))
      (error "DIVISION BY ZERO NOT POSSIBLE -- DIV-SERIES" a b)
      (let ((carb (stream-car b)))
	;; make b a unit series and do the rest of task
	(mul-series (scale-stream a (/ carb)) (invert-unit-series (scale-stream b (/ carb)))))))

(define tan-series (div-series sine-series cosine-series))

;; works perfectly
