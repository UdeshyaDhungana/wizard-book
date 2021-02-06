
					;Finding all ordered triplets less than n such that they sum pu to give the number s

					;NOTE: Load 'nested_mappings.scm' before this file

(define (triplets n)
  (flatmap (lambda (i)
	     (flatmap (lambda (j)
			(map (lambda (k)
			       (list i j k))
			     (enumerate-interval 1 j)))
		      (enumerate-interval 1 i)))
	   (enumerate-interval 1 n)))

(define (sum-to-s seq s)
  (= s (+ (car seq) (cadr seq) (caddr seq))))

(define (sum-triplets n s)
  (filter (lambda (x)
	    (sum-to-s x s)) (triplets n)))
