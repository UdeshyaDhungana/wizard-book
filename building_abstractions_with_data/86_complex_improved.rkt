
;; Allowing complex number to have real and imaginary parts of arbitrary types

(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))

;; add to scheme number package

(put 'sine 'scheme-number
     (lambda (x) (tag (sin x))))

(put 'cosine 'scheme-number
     (lambda (x) (tag (cos x))))


;; add to rational package

(put 'sine 'rational
     (lambda (x) (tag (sin x))))

(put 'cosine 'rational
     (lambda (x) (tag (cos x))))

;; Replace +, *, -, / with their generic counterparts

(define (add-complex z1 z2)
   (make-from-real-imag (add (real-part z1) (real-part z2))
                        (add (imag-part z1) (imag-part z2))))
 (define (sub-complex z1 z2)
   (make-from-real-imag (sub (real-part z1) (real-part z2))
                        (sub (imag-part z1) (imag-part z2))))
 (define (mul-complex z1 z2)
   (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                      (add (angle z1) (angle z2))))
 (define (div-complex z1 z2)
   (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                      (sub (angle z1) (angle z2))))


;; Not implementing this one in the main program because i've wasted enough hours of my life
