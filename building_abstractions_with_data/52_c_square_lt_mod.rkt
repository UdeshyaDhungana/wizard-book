#lang racket

(require sicp-pict)
(require "yakshyu.rkt")

;Modifying Mr. Rogers' image to make him look away from the center
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (below (beside (bl painter) (br painter))
           (beside (tl painter) (tl painter)))))

;; changing square limit procedure
(define (square-limit painter n)
  ;; top left identity, top right flip horizontally
  ;; bottom left flip-vert bottom right rotate180
  (let ((combine4 (square-of-four identity flip-horiz
                                  flip-vert rotate180)))
    (combine4 (corner-split painter n))))
