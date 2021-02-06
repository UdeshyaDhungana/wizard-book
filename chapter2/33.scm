					;
(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))

					;Implement these functions as accumulate

;Apply substitution
(define (map procedure sequence)
  (accumulate (lambda (x y)
		(cons (procedure x) y)) () sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))
