#lang racket
; --- Prime computation ---

(require "../lib.rkt")

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next x)
    (if (= x 2) 3 (+ x 2)))
  (cond ((> (sqr test-divisor) n) n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
                n
                (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; --- Timing ---

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (current-milliseconds) start-time))
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
          (else (newline) (display "done")))))

(search-for-primes 10000000 10000103)
(search-for-primes 100000000 100000039)
(search-for-primes 1000000000 1000000021)

;By 2008, computers became so fast, operations specified on book would not be noticed, we'd need to feed numbers in the order of hundred of millions to see noticeable time delay.

; Test 
; Restults are expected to  be twice as fast as previous case because we skipped all the odd numbers

;Test time
;   Order   | 10 million    |     100 million     |   1 billion
;   Time    | 3ms           |     10.33ms         |    30.33ms

;Average factor by which time is reduced is 1.5
; It is expected to be 2 but, due to `if` overhead in `next` function,
; the desired factor is not observed

;Everything checks out
