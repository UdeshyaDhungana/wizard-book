					;Subset of a set
(define (subsets s)
  (if (null? s)
      (list ())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (array)
			    (cons (car s) array)) rest)))))

					;Again, we make use of wishful thinking!
					;Let, rest denote the subset of the set formed by excluding the first element of the set, then
					;The total subset of the original set is the union of the subset of the rest of the set and
					;the set that is formed by appending the first element to each item in the subset of the rest of the set

					;Remember that this is under the assumption that the original set(list)
					;does not contain repeated elements.



					;I hope you get it
					;If you don't, please construct a n(A) = 3 set and experiment it for yourself!
