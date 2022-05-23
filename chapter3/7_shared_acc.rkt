#lang racket


;; My solution involves making a list of passwords
;; On calling make-joint, add-pw procedure is called
;; which adds this new password onto the list of passwords
(define (make-account balance password)
  (let ((passwords (list password)))

    (define (match-passwd? passwd passwords)
      (cond ((null? passwords) false)
            ((eq? (car passwords) passwd) true)
            (else (match-passwd? passwd (cdr passwords)))))
    
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))

    (define (deposit amount)
      (begin (set! balance (+ balance amount))
             balance))

    (define (incorrect amount)
      "Incorrect password")

    (define (add-pw new-pw)
      (begin (set! passwords (cons new-pw passwords))
             dispatch))

    (define (dispatch passwd m)
      (if (match-passwd? passwd passwords)
          (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'add-pw) add-pw)
                ((eq? m 'deposit) deposit)
                (else (error "Unavilable function -- MAKE-ACCOUNT"
                             m)))
          incorrect))
    
    dispatch))

(define (make-joint orig-acc orig-passwd new-passwd)
  ((orig-acc orig-passwd 'add-pw) new-passwd))


(define foo-acc (make-account 100 'passwd))

(define bar-acc (make-joint foo-acc 'passwd 'new-passwd))

((bar-acc 'new-passwd 'withdraw) 10)

((foo-acc 'passwd 'deposit) 10)
