
					;Some matrix operations
					;Let's represent sequences of numbers as vectors and sequences of vectors as matrix (rows of the matrix)

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence) (accumulate operation initial (cdr sequence)))))

(define (dot-product u v)
  (accumulate + 0 (map * u v)))

(define (matrix-*-vector m v)
  (map (lambda (x)
	 (dot-product x v)) m))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      ()
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
	    (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

(define (transpose mat)
  (accumulate-n cons () mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x)
	   (matrix-*-vector cols x)) m)))

;This is beyond science, jk, i cannot describe this beauty
