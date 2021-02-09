
					;Representing sets as list that allows duplication

(define (element-of-set? set item)
  (cond ((null? set) #f)
	((equal? (car set) item) #t)
	(else (element-of-set? (cdr set) item))))
;O(n)

(define (adjoin-set x set)
  (cons x set))
;O(1)

(define (union-set s1 s2)
  (append s1 s2))
;O(n)

(define (intersection-set s1 s2)
  (cond ((or (null? s1) (null? s2)) ())
	((element-of-set? (car s1) s2)
	 (cons (car set1)
	       (intersection-set (cdr s1) s2)))
	(else (intersection-set (cdr s1) s2))))
;O(n^2)
					;I'd use this representation if I have enough space available,
					;and when adjoining and union is more necessary than other operations

