; --- Prime computation ---

(define (runtime) (real-time-clock))

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
                n
                (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; --- Timing ---

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))
    "nothing"))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

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

;By 2008, computers became so fast, operations specified on book would not be noticed, we'd need to feed numbers in the order of hundred of millions to see noticeable time delay.

;Test time
;   Order   | 10 million    |     100 million     |   1 billion
;   Time    | 5ms           |     14.33ms         |    42.33ms

; 14.33 / sqrt(10) = 4.53 ~ 5
; 42.33 / sqrt(10) = 13.38 ~ 14.33

;Everything checks out
