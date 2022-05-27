#lang sicp

;; Let's count pairs

;; If current is visited, return 0
;; if not, 1 + car of current + cdr of current

;; if visited, return 0
;; else, add that to visited list, return
;; (+ 1 (count-pairs (car x)) (count-pairs (cdr x)))

(define (count-pairs x)
  (let ((visited '()))
    (define (helper x)
      (if (or (not (pair? x)) (memq x visited))
          0
          (begin
            (set! visited (cons x visited))
            (+ (helper (car x))
               (helper (cdr x))
               1))))
    (helper x)))


(count-pairs '(2 3 (4 . 5) (1 2 9 10)))
(count-pairs '(1 2))
