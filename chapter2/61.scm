
					;As ordered list

(define (adjoin-set x set)
  (cond ((null? set) (list x));Empty then add it
	((= x (car set)) set);Exists, then ignore
	((< x (car set)) (cons x set));x is smaller than first element of set, add it there to the set
	(else (cons (car set) (adjoin-set x (cdr set))))));else, cons current element of set with the adjoin of x with cdr set

