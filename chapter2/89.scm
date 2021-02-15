
;; Polynomial representation for dense polynomial

;; some functions

;; individual term is still (order coefficient) pair
(define (first-term term-list)
  (list (- (length term-list) 1) (car term-list)))

;; assuming new term has higher order than all other terms
(define (adjoin-term term termlist)
  ;; produces a list of n zeros
  (define (produce-zero n)
    (if (= n 0)
	'()
	(cons 0 (produce-zero (- n 1)))))
  (cond ((=zero? (coeff term))
	 termlist
	 (append (cons (coeff term) (produce-zero (- (order term) (length termlist))))
		 termlist))))



;; another genius solution i found at wiki
  
 (define (adjoin-term term term-list) 
   (cond ((=zero? term) term-list) 
         ((=equ? (order term) (length term-list)) (cons (coeff term) term-list)) 
         (else (adjoin-term term (cons 0 term-list)))))
