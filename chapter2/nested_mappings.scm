
					;Nested mappings
					;Generate an ordered pair (x y) such that x+y is prime

					;Dependencies
(define (enumerate-interval low high)
  (if (> low high)
      ()
      (cons low (enumerate-interval (+ low 1) high))))


(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))

(accumulate append ()
	    (map (lambda (i)
		   (map (lambda (j) (list i j))
			(enumerate-interval 1 (- i 1))))
		 (enumerate-interval 1 4)))

;This can be defined as follows:
					;For each element from 1 to 4 (i), make a list from 1 to i-1 and for each element in that list -> make a pair (i,j)


(define (flatmap proc sequence)
  (accumulate append () (map proc sequence)))


					;Prime measuring part
(define divides?
  (lambda (a b)
    (= (remainder a b) 0)))
 
(define prime?
  (lambda (n)
    (cond ((or (= n 1) (= n 0)) #f)
      ((= n 2) #t)
      ((even? n) #f)
      (else (let prime-test ( (d 3) )
          (cond ((> (square d) n) #t)
            ((divides? n d) #f)
            (else (prime-test (+ d 2)))))))))
;;;;;;;;;;;;;;;

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (filter predicate sequence)
  (cond ((null? sequence) ())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (prime-sum-pairs n)
  (map make make-pair-sum
       (filter prime-sum?
	       (flatmap
		(lambda (i)
		  (map (lambda (j) (list i j))
		       (enumerate-interval 1 (- i 1))))
		(enumerate-interval 1 n)))))


					;Here's the explanation. First we flatmap the sequence from 1 to n.
					;Flatmap:
					;For each element(i) in 1 to n, create a sequence 1 to i;


					;Let's generate permutationsx

(define (permutations s)
  (if (null? s)
      (list ())
      (flatmap (lambda (x)
		 (map (lambda (p) (cons x p))
		      (permutations (expunge x s))))
	       s)))

(define (expunge item list)
  (filter (lambda (x) (not (= x item))) list))

