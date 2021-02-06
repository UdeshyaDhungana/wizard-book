					;Change making using list

(define (count-change amount)
  (cc amount 5))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (no-more? l)
  (< (length l) 1))

(define (except-first-denomination l)
  (cdr l))

(define (first-denomination l)
  (car l))

(define nepal-coins (list 50 20 10 5 2 1))

(cc 100 nepal-coins)
