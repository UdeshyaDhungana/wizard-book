

;; Averager

(define (averager a b c)
  (let ((p (make-connector))
	(q (make-connector)))
    (adder a b p)
    (multiplier c q p)
    (constant 2 q)
    ok))

     ;;   	       			   	      +-----+
     ;; a----+----------+	 p   +----------+-----|c    +
     ;;  	  |   +      +-------+    *     |     +-----+
     ;; b----+---------++	     +----------+-----+--+
     ;; 			  		   q  |2 |
     ;; 					      +--+
