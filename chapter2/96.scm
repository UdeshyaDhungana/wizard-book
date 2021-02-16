
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

;; Now gcd has integer coefficients, but they are larger than that of P1
;; Now let's divide each coefficients by gcd of all the coefficients and
;; voila, we have here coefficients without common factors

;; b
;; Implementation change

(define (remove-constant-factor termlist)
  (if (empty-termlist? termlist)
      termlist
      (let* ((common-gcd (map greatest-common-divisor each-term)) ;gcd of all the coefficients
	     (divisor (adjoin-term (make-term 0 common-gcd) (the-empty-termlist))))
	(car (div-terms termlist divisor)))))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      (remove-constant-factor a)
      (gcd-terms b (pseudoremainder-terms a b))))
