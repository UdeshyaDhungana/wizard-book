
;; generating using weighted function

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
	((stream-null? s2) s1)
	(else
	 (let ((s1car (stream-car s1))
	       (s2car (stream-car s2)))
	   (cond ((< (weight s1car) (weight s2car))
		  (cons-stream s1car (merge-weighted (stream-cdr s1)
						     s2
						     weight)))
		 ((< (weight s2car) (weight s1car))
		  (cons-stream s2car (merge-weighted s1 (stream-cdr s2) weight)))
		 (else (cons-stream s1car (cons-stream s2car (merge-weighted (stream-cdr s1)
									     (stream-cdr s2) weight)))))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
    weight)))

;; part a
(define i (weighted-pairs integers integers (lambda(x) (+ (car x) (cadr x)))))

;; part b
;; returns true if num is not divisible by 2, 3 and 5

;; return true if x is divisible by y
(define (not-divisible x y)
  (not (= 0 (remainder x y))))

(define (not-divisible-2-3-5 num)
  (and (not-divisible num 2)
       (not-divisible num 3)
       (not-divisible num 5)))

(define i (stream-filter (lambda(z)
			   (and (not-divisible-2-3-5 (car z))
				(not-divisible-2-3-5 (cadr z))))
			 (weighted-pairs
			  integers
			  integers
			  (lambda(x)
			    (+ (* 2 (car x))
			       (* 3 (cadr x))
			       (* 5 (car x) (cadr x)))))))

;; checked and verified

;; this can be done in other way too
;; first generating those pairs which are neither divisible,
;; and then ordering them according to weight

;; like this
;; gives weight function
(define (factored-weight x)
  (let ((i (car x))
        (j (cadr x)))
    (+ (* 2 i) 
       (* 3 j) 
       (* 5 i j))))

;; filter for divisibility
(define (unfactored? x)
  (not (or (even? x)
           (zero? (remainder x 3))
           (zero? (remainder x 5)))))

;; filtered one
(define unfactored
  (stream-filter unfactored? integers))

;; finally order them according to their weight
(define answer (weighted-pairs unfactored
                unfactored
                factored-weight))
