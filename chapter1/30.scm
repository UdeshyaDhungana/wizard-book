
;Iterative sum procedure

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
            result
            (iter (next a) (+ result (term a)))))
  (iter a 0))


(define (next x)(+ x 1))
(sum square 1 next 10)
