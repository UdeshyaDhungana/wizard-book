
(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))

;; this function returns a stream that is the result of decimal division of (* num radix) by den

(expand 1 7 10)
;; This produces {1 4 2 8 5 7 1 4 2 ...}

(expand 3 8 10)
;; This produces {3 7 5 0 0 0 0 0 0 ...}
