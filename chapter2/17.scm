					;Last pair implementation

(define (last-pair l)
  (if (<= (length l) 1)
      l
      (last-pair (cdr l))))
