;Implementation according to Ben's suggestion

(define (pos? x)
  (> x 0))

(define (neg? x)
  (< x 0))

(define (make-interval a b)
  (if (> a b)
    (cons b a)
    (cons a b)))

;Exercise
(define (lower interval) (car interval))
(define (upper interval) (cdr interval))

(define (mul-interval x y)
  (let ((a (lower x))
        (b (upper x))
        (c (lower y))
        (d (upper y)))
    (cond ((and (pos? a) (pos? b) (pos? c) (pos? d))
           (make-interval (* a c) (* b d)))

          ((and (pos? a) (pos? b) (neg? c) (pos? d))
           (make-interval (* b c) (* b d)))

          ((and (pos? a) (pos? b) (neg? c) (neg? d))
           (make-interval (* b c) (* a d)))

          ((and (neg? a) (pos? b) (pos? c) (pos? d))
           (make-interval (* a d) (* b d)))

          ((and (neg? a) (pos? b) (neg? c) (neg? d))
           (make-interval (* b c) (* a c)))

          ((and (neg? a) (neg? b) (pos? c) (pos? d))
           (make-interval (* a d) (* b c)))

          ((and (neg? a) (neg? b) (neg? c) (pos? d))
           (make-interval (* a d) (* a c)))

          ((and (neg? a) (pos? b) (neg? c) (pos? d))
           (let ((p (* a d)))
             ((q (* b c)))
             ((r (* a c)))
             ((s (* b d)))
             (make-interval (min p q) (max r s))))

          ((and (neg? a) (neg? b) (neg? c) (neg? d))
           (make-interval (* b d) (* a c))))))
