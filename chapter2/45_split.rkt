#lang racket

(require sicp-pict)

(define (split big-split small-split)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split big-split small-split) painter (- n 1))))
          (big-split painter
                     (small-split smaller smaller))))))
