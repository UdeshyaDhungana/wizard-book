#lang racket

(define (for-each proc items)
  (cond ((not (null? items))
	 (proc (car items))
	 (for-each proc (cdr items)))))

;; 🥳
(for-each (lambda (x)
            (display x)
            (newline))
          '(1 2 3 4 5))

;; Just kidding
;; (define 🥳 '(9 8 3))
;; (for-each (lambda (x)
;;             (display x)
;;             (newline))
;;           🥳)
