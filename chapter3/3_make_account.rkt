#lang racket

;; Tomorrow

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount)))

  (define (incorrect amount)
    "Incorrect password")

  (define (dispatch passwd m)
    (if (eq? passwd password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unavilable function -- MAKE-ACCOUNT"
                           m)))
        incorrect))
  dispatch)


(define acc (make-account 100 'secret))

((acc 'secret 'withdraw) 40)

((acc 'another 'deposit) 100)
