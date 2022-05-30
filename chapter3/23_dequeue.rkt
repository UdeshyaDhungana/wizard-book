#lang sicp
;; Representing dequeues

(define (front-ptr dequeue) (car dequeue))
(define (rear-ptr dequeue) (cdr dequeue))

(define (set-front-ptr! dequeue item) (set-car! dequeue item))
(define (set-rear-ptr! dequeue item) (set-cdr! dequeue item))

(define (empty-dequeue? dequeue) (null? (front-ptr dequeue)))
(define (make-dequeue) (cons '() '()))

;; One unit of data holding, contains
;; previous pointer
;; holding data
;; next pointer

(define (make-dcell item)
  (cons (cons '() item) '()))
(define (prev-pointer dcell)
  (caar dcell))
(define (data dcell)
  (cdar dcell))
(define (next-pointer dcell)
  (cdr dcell))

(define (set-prev-pointer! dcell item)
  (set-car! (car dcell) item))
(define (set-data! dcell item)
  (set-cdr! (car dcell) item))
(define (set-next-pointer! dcell item)
  (set-cdr! dcell item))

(define (front-dequeue dequeue)
  (if (empty-dequeue? dequeue)
      (error "FRONT called with an empty dequeue" dequeue)
      (data (front-ptr dequeue))))

(define (rear-dequeue dequeue)
  (if (empty-dequeue? dequeue)
      (error "REAR called with an empty dequeue" dequeue)
      (data (rear-ptr dequeue))))

(define (front-insert-dequeue! dequeue item)
  (let ((new-dcell (make-dcell item)))
    (if (empty-dequeue? dequeue)
	(rear-insert-dequeue! dequeue item)
	(begin (set-next-pointer! new-dcell (front-ptr dequeue))
	       (set-prev-pointer! (front-ptr dequeue) new-dcell)
	       (set-front-ptr! dequeue new-dcell)
	       dequeue))))

(define (rear-insert-dequeue! dequeue item)
  (let ((new-dcell (make-dcell item)))
    (cond ((empty-dequeue? dequeue)
           (set-front-ptr! dequeue new-dcell)
           (set-rear-ptr! dequeue new-dcell)
           dequeue)
          (else
           (set-next-pointer! (rear-ptr dequeue) new-dcell)
	   (set-prev-pointer! new-dcell (rear-ptr dequeue))
	   (set-rear-ptr! dequeue new-dcell)
	   dequeue))))

(define (front-delete-dequeue! dequeue)
  (cond ((empty-dequeue? dequeue)
         (error "DELETE! called with an empty dequeue" dequeue))
        (else
         (set-front-ptr! dequeue (next-pointer (front-ptr dequeue)))
	 (if (not (null? (front-ptr dequeue)))
	     (set-prev-pointer! (front-ptr dequeue) '()))
	 dequeue)))

(define (rear-delete-dequeue! dequeue)
  (cond ((empty-dequeue? dequeue)
	 (error "DELETE! called with an empty dequeue" dequeue))
	(else
	 (set-rear-ptr! dequeue (prev-pointer (rear-ptr dequeue)))
	 (if (not (null? (rear-ptr dequeue)))
	     (set-next-pointer! (rear-ptr dequeue) '()))
	 dequeue)))

;; ========================================
;; Print dequeue

;; Doesn't take care of self referential dequeues
(define (print-dequeue q)
  ;; prints content of dcell
  (define (print-dcell-list x)
    (if (not (null? x))
	;; cdar means data of dcell
	(begin (display (cdar x))
	       (display " ")
	       (print-dcell-list (next-pointer x)))))
  (print-dcell-list (front-ptr q)))
