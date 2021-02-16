

;; we have gcd terms that returns gcd of two terms, (gcd-terms a b)

;; all functions are already defined
(define (reduce-terms n d)
  (let ((gcd-of-both (gcd-terms n d)))
    (list (car (div-terms n gcd-of-both))
	  (car (div-terms d gcd-of-both)))))


(define (reduce-poly a b)
  (if (same-variable? (variable a)
		      (variable b))
      (make-poly (variable a) (reduce-term (term-list a)
					   (term-list b)))
      (error "polys in different vars -- REDUCE-GCD"
	     (list a b))))


;; Solution to b
;; inside polynomial package

;; inside integer package
(define (reduce-integers n d)
  (let ((g (gcd n d)))
    (list (/ n g) (/ d g))))

;; putting generic reduce operations to the table
(put 'reduce '(scheme-number scheme-number) reduce-integers)
(put 'reduce '(polynomial polynomial) reduce-poly)

;; inside rational package
(define (make-rat a b)
  (reduce a b))

;; if a and b are integers, reduce integers is called
;; if they are polynomials, reduce poly will be called
;; truly the power of generic operations!!!
