#lang racket

(require sicp-pict)

(define (below painter1 painter2)
  (let ((split-point (make-vector 0 0.5)))
    (let ((upper-painter (transform-painter painter2
                                            split-point
                                            (make-vect 1 0.5)
                                            (make-vect (0 1))))
          (lower-painter (transform-painter painter1
                                            (make-vect 0 0)
                                            (make-vect 1 0)
                                            (make-vect split-point))))
      (lambda (frame)
        (upper-painter frame)
        (lower-painter frame)))))

;A combined painter that paints side by side
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))


(define (rotate90-counterclockwise painter)
  (transform-painter painter (make-vector 1 0) (make-vector 1 1) (make-vector 0 0)))


(define (below2 painter1 painter2)
  (rotate90-counterclockwise (beside (transform-painter painter1
                                                         (make-vector 0.5 0)
                                                         (make-vector 0.5 1)
                                                         (make-vector 0 0))

                                      (transform-painter painter2
                                                         (make-vector 1 0)
                                                         (make-vector 1 1)
                                                         (make-vector 0.5 0)))))
