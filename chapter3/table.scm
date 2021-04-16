;; Table implementation: Single key

;; procedure to perform lookup on the table
(define (lookup key table)
(let ((record (assoc key (cdr table))))
  (if record
      (cdr record)
      false)))

;; search for the given key , if found return it, else return false
(define (assoc key records)
(cond ((null? records) false)
((equal? key (caar records)) (car records))
(else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
	(set-cdr! record value)
	(set-cdr! table
		  (cons (cons key value) (cdr table)))))
  'ok)

(define (make-table)
  (list '*table*))
