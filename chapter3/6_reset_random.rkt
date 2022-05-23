;; Theoretical question
;; Resetting the random number

(define (rand)
  (let ((x random-init))
    (define (dispatch message)
      ;; on getting symbol 'generate, we return a value
      (cond ((eq? message 'generate)
             (begin (set! x (rand-update x))
                    x))
            ((eq? message 'reset)
             ;; on gettting 'reset, we return a function
             (lambda (value)
               (set! x value)))))
    dispatch))

;; rand is a variable that represents a function
