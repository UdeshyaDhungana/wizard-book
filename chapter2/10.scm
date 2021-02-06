;Implement interval

(define (make-interval a b) (cons a b))

;Exercise
(define (lower-bound interval) (min (cdr interval) (car interval)))
(define (upper-bound interval) (max (cdr interval) (car interval)))

;From book
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

;From book
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;From book
(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))


;Textbook signals div-interval can be faulty because dividing by an interval that includes `0` will break the system

(define i (make-interval 5 6))
(define j (make-interval -1 1))

(define k (div-interval i j))

;This returns (-6,6)
;This is clearly not a solution, as the second solution contains 0, the solution would have been (-6, inf)

(define (div-fullproof x y)
  (if (< (* (lower-bound y) (upper-bound y)) 0)
    (error "Divisor bound spans zero!")
    (div-interval x y)))
