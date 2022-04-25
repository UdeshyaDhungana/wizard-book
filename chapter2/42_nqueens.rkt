#lang racket

(require "../lib.rkt")

;For representing empty board
(define empty-board null)

;For representing the position
(define (make-position row column)
  (cons row column))

(define (position-row position)
  (car position))

(define (position-column position)
  (cdr position))

(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list (make-position new-row k))))

;Mine
(define (safe? column-number combinations)
  (let ((current-queen (list-ref combinations (- column-number 1)))
        (other-queens (filter (lambda (position)
                                (not (= (position-column position) column-number)))
                              combinations)))
    ;Returns true if queen in p1 checks queen in q2
    (define (checks? p1 p2)
      (or (= (position-row p1) (position-row p2))
          (= (abs (- (position-row p1) (position-row p2)))
             (abs (- (position-column p1) (position-column p2))))))
    
    (define (iter-safe? my-queen others)
      (if (null? others)
          #t
          (and (not (checks? my-queen (car others))) (iter-safe? my-queen (cdr others)))))
    (iter-safe? current-queen other-queens)))


(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
