#lang sicp
;; Implementing Queue as a procedure with state

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    
    (define (empty-queue?)
      (null? front-ptr))
    
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue" (cons front-ptr rear-ptr))
          (car front-ptr)))
    
    (define (set-front-ptr! item)
      (set! front-ptr item))
    
    (define (set-rear-ptr! item)
      (set! rear-ptr item))
    
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               (cons front-ptr rear-ptr))
              (else
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)
               (cons front-ptr rear-ptr)))))

    (define (delete-queue!)
      (if (empty-queue?)
          (error "DELETE! called with an empty queue" (cons front-ptr rear-ptr))
          (begin (set-front-ptr! (cdr front-ptr))
                 (cons front-ptr rear-ptr))))
    
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) (empty-queue?))
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) (delete-queue!))
            (else (error "UNKNOWN OPERATION -- " m))))
    dispatch))

;; ==================================================

;; Test modules
(define (disp x)
  (display x)
  (display "\n"))
;; ;; Takes in empty queue, and does stuff
(define (test a)
  (disp (a 'empty-queue?))
  (disp ((a 'insert-queue!) 3))
  (disp (a 'empty-queue?))
  (disp (a 'front-queue))
  (disp ((a 'insert-queue!) 4)))
