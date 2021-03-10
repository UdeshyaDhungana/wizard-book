
;; Let's count pairs

;; If current is visited, return 0
;; if not, 1 + car of current + cdr of current

;; if visited, return 0
;; else, add that to visited list, return
;; (+ 1 (count-pairs (car x)) (count-pairs (cdr x)))

(define visited '())

(define (count-pairs x)
  (if (not (pair? x))
      0
      (if (memq x visited)
	  0
	  (begin (set! visited (cons x visited))
		 (+ 1 (count-pairs (car x))
		    (count-pairs (cdr x)))))))
