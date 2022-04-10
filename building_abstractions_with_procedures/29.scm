
;Simpson's rule

(define (sum term a next b)
  (cond ((> a b) 0)
        (else (+ (term a) (sum term (next a) next b)))))


(define (simpsons f a b n)
  (define h (/ (- b a) n))

  (define (multiplier k)
    (cond ((or (= k 0) (= k n)) 1)
          ((even? k) 2)
          (else 4)
          )
  )

  (define (simp-term i)
    (* (f (+ a (* i h))) (multiplier i)))

  (define (simp-next x)(+ x 1))

  (* (sum simp-term 0 simp-next n) (/ h 3))
)

(define (cube x)
  (* x x x))

(simpsons cube 0 1 1000)
