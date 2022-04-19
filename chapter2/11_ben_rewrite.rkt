#lang racket
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
            ;; done 15
    (cond ((and (pos? a) (pos? b) (pos? c) (pos? d))
           (make-interval (* a c) (* b d)))

          ;; done 13
          ((and (pos? a) (pos? b) (neg? c) (pos? d))
           (make-interval (* b c) (* b d)))

          ;; done 12
          ((and (pos? a) (pos? b) (neg? c) (neg? d))
           (make-interval (* b c) (* a d)))

          ;; done 7
          ((and (neg? a) (pos? b) (pos? c) (pos? d))
           (make-interval (* a d) (* b d)))

          ;; done 4
          ((and (neg? a) (pos? b) (neg? c) (neg? d))
           (make-interval (* b c) (* a c)))

          ;; done 3
          ((and (neg? a) (neg? b) (pos? c) (pos? d))
           (make-interval (* a d) (* b c)))

          ;;done 1
          ((and (neg? a) (neg? b) (neg? c) (pos? d))
           (make-interval (* a d) (* a c)))

          ;; done 5
          ((and (neg? a) (pos? b) (neg? c) (pos? d))
           (let ((p (* a d))
                 (q (* b c))
                 (r (* a c))
                 (s (* b d)))
             (make-interval (min p q) (max r s))))

          ;; done 0
          ((and (neg? a) (neg? b) (neg? c) (neg? d))
           (make-interval (* b d) (* a c))))))
