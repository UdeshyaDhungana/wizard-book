;; Polynomial representation for dense polynomial

;; some functions

(define (first-term term-list)
  (make-term (- (length term-list) 1) (car term-list)))

(define (adjoin-term term term-list)
  (cond ((=zero? term) term-list)
        ((= (order term) (length term-list))
         (cons (coeff term) term-list))
        (else (adjoin-term term (cons 0 term-list)))))
