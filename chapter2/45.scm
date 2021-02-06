
					;Implementation of split procedure

(define (split first second)
  (define (base painter n)
    (if (= n 0)
	painter
	(first painter (second (base (- n 1))))))

  base)
