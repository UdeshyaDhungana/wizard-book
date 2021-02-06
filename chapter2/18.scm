					;Reverse list edition

;Load last file: last-item utility
(load "17.scm")

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

;This is highly inefficient because of its complexity
(define (reverse l)
  (if (<= (length l) 1)
      l
      (append (reverse (cdr l)) (list (car l)))))

;Took hint from the internet
(define (reverse-smart l)
  (define (iter item result)
    (if (null? item)
	result
	(iter (cdr item) (cons (car item) result))))
  (iter l ()))
