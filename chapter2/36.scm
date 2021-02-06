					;Accumulate-n procedure

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      ()
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
	    (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

;Note: you can replace (lambda (x) (car x)) by just car because it's also an operation on the list
