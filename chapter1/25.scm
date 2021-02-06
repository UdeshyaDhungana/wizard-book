
;Modification of timed-prime-test to use fast-prime

; --- Prime computation ---


(define (square x)
  (display "Square") (display x) (newline)
  (* x x))

(define (fast-exponentian base exponent)
  (define (fexp b n a)
    (cond ((= n 0) a)
          ((even? n) (fexp (square b) (/ n 2) a))
          (else (fexp b (- n 1) (* a b)))))
  (fexp base exponent 1))

(define (alyssa-p-hacker-expmod base expo m)
  (remainder (fast-exponentian base expo) m))


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))


(expmod 5 101 101)

(alyssa-p-hacker-expmod 5 101 101)

;Why Alyssa's implementation is slower can be seen from the output of this file
;While the `expmod` procedure has to square small numbers
;`alyssa-p-hacker-expmod` procedure has to square enormous numbers compared to `expmod`
;
; Scheme can do arbitrary precision arighmetic, but with large numbers, computation becomes
; slower
