
					;Vectors implementation

(define (make-vect x y)
					;Was car-cdr pair at first but
					;Decided to make it a list so that scalability is preserved
					;Codebase doesn't change much on changing the representation of vectors
  
  (list x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cadr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
	     (+ (ycor-vect v1) (ycor-vect v2))))


(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
	     (- (ycor-vect v1) (ycor-vect v2))))


(define (scale-vect scalar v)
  (make-vect (* scalar (xcor-vect v)) (* scalar (ycor-vect v))))
