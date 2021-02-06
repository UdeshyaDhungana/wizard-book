					;Second representation of rectangle


(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-rect top-left bottom-right)
  (cons top-left bottom-right))

(define (top-left rect)
  (car rect))

(define (bottom-right rect)
  (cdr rect))

(define (perimeter rect)
  (let ((height (- (y-point (top-left rect)) (y-point (bottom-right rect))))
	(width (- (y-point (top-left rect)) (y-point (bottom-right rect)))))
    (* 2 (+ height width))))

(define (area rect)
  (let ((height (- (y-point (top-left rect)) (y-point (bottom-right rect))))
	(width (- (y-point (top-left rect)) (y-point (bottom-right rect)))))
    (* height width)))


(define start (make-point 2 3))
(define end (make-point 5 0))

(define my-rect (make-rect start end))

(perimeter my-rect)
(area my-rect)
