;Church Numerals

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

;(zero x) -> Returns an identity procedure 

;one can be obtained by applying add-1 onto zero
;So,
;(add-1 zero)
;(lambda (f) (lambda(x) (f ((zero f) x))))
;>>>>>>
;((zero f) x)
;x            ;identity applied to x is just x
;>>>>>>
;(lambda (f) (lambda (x) (f x)))

(define one (lambda (f) (lambda (x) (f x))))

;Similarly, two can be obtained by applying add-1 onto one

;(one f) -> (lambda(x) (f x))
;((one f) x) -> (f x)

;(add-1 one)
;(lambda(f) (lambda(x) (f ((one f) x))))
;(lambda(f) (lambda(x) (f (f x))))
;So,

(define two (lambda(f) (lambda(x) (f (f x)))))

;Making addition using church

(define (add a b)
  (lambda (f)
    (lambda(x)
      ( (a f) ((b f) x) ))))


;(b f) -> returns a procedure that applies f to its arguments b times
;((b f) x) -> b applications of f onto x

;(a f) -> returns a procedure that applies f to its arguments a times
;(a f) ((b f) x) -> a applications of f onto (b applications of f onto x)

;Goddamn this is beautiful and borderline insanity
