
;; load 59.scm before this file

(define (add-streams a b)
  (cons-stream (+ (stream-car a) (stream-car b)) (add-streams (stream-cdr a) (stream-cdr b))))

(define (scale-stream a factor)
  (cons-stream (* (stream-car a) factor) (scale-stream (stream-cdr a) factor)))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2)) (add-streams (scale-stream (stream-cdr s1) (stream-car s2) ) (mul-series s1 (stream-cdr s2)))))

(define result (add-streams (mul-series sine-series sine-series) (mul-series cosine-series cosine-series)))
;; Value = {1 0 0 0 ...}
;; ==================================================


;; Explanation for multiply procedure (I'm so proud of myself for doing this)
;; ==================================================
;; Let the two series be a = {a0 a1 a2 a3 a4 ...} and b = {b0 b1 b2 b3 b4 ...}

;; The multiplication will producet this

;; a0b0 a0b1 a0b2 a0b3 a0b4 ...
;; a1b0 a1b1 a1b2 a1b3 a1b4 ...
;; a2b0 a2b1 a2b2 a2b3 a2b4 ...
;; a3b0 a3b1 a3b2 a3b3 a3b4 ...
;; a4b0 a4b1 a4b2 a4b3 a4b4 ...
;; ............................
;; ............................

;; Each nth diagonal represents the summands of coefficient of product
;; for n-1th degree in polynomial ter. For eg. 2nd diagonal has the terms
;; a0b1 and a1b0. Summing these we get the coefficient of degree 1 (2-1)
;; of the product

;; In the mul-series procedure, car of result is the topmost element
;; a0b0,the rest is the sum of (first column from second row) and (the
;; matrix excluding first column)

;; You'll see why this is the answer. The explanation above will be
;; enough.
