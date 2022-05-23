#lang racket

(require sicp-pict)

(define ds diagonal-shading)

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
            (corner (corner-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right)))
          (below (beside painter bottom-right)
                 (beside top-left corner))))))

(define (square-limit painter n)
  (if (= n 0)
      painter
      (let* ((cs (corner-split painter (- n 1)))
             (top-half (beside (flip-horiz cs) cs)))
        (below (flip-vert top-half) top-half))))

(provide square-limit
         corner-split
         up-split
         right-split)
