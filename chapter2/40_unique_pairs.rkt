
					;NOTE: Load the `nested_mappings.scm` before this file

(define (unique-pairs n)
n  (flatmap (lambda (i)
	     (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1)))
	     ) (enumerate-interval 1 n)))

(define (prime-sum-pairs-mine num)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs num))))
