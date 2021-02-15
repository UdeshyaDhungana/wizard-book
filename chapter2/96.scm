
;; as said
(define (pseudoremainder-terms a b)
  (let* ((o1 (order (first-term a)))
	 (o2 (order (first-term b)))
	 (c (coeff (first-term b)))
	 (dividend (mul-term-by-all-terms (make-term 0 (expt c (+ 1 (- o1 o2))))
					  a)))
    (cadr (div-terms dividend b))))


(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (pseudoremainder-terms a b))))

;; b
(define (gcd-terms a b)
  (if (empty-termlist? b)
      (let* ((coeff-list (map coeff a))
	     (gcd-coefficient (apply gcd coeff-list)))
	(div-terms a (make-term 0 gcd-coefficient)))
      (gcd-terms b (pseudoremainder-terms a b))))
