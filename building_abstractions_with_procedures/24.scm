
;Modification of timed-prime-test to use fast-prime

; --- Prime computation ---

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

; --- Timing ---

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (fast-prime? n 1000)
    (report-prime (- (runtime) start-time))
    "nothing"))

(define (search-for-primes start end)
  (if (even? start)
    (search-for-primes (+ start 1) end)
    (cond ((<= start end) 
           (timed-prime-test start)
           (search-for-primes (+ start 2) end))
          (else (newline) (display "done"))
          )
    )
  )

(search-for-primes 10000000 10000103)
(search-for-primes 100000000 100000039)
(search-for-primes 1000000000 1000000021)
(search-for-primes 10000000000 10000000100)

; Let's see

; Test 

;Test time
;   Order   | 10 million    |     100 million     |   1 billion  | 10 billion
;   Time    | 0.046ms       |     0.06ms          |    0.067ms   | 0.0833ms

; Roughly, for one digit added, code ran 1.20 times slower

;Everything checks out
