
					;Implementation of reverse using fold-left and accumulate


(define (reverse sequence)
  (accumulate (lambda (first result) (append result (list first)) () sequence))

(define (reverse-fold sequence)
  (fold-left (lambda (result first) (cons first result)) () sequence))
