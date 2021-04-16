
;; At first I thought, let's make an n-dimensional table, then I realized,
;; and by realized, I mean looked up in the internet after 2 hours of desparate trying,
;; that I could store keys in a list and compare these lists to do usual stuff,
;; which makes this one dimensional table

(define (make-table)
  (define table (list '*table*))

  ;; Lookup procedure
  (define (assoc key records)
    (cond ((null? records) false)
	  ((equal? key (caar records)) (car records))
	  (else (assoc key (cdr records)))))

  ;; Lookup procedure
  (define (lookup key)
    (let ((record (assoc key (cdr table))))
      (if record
	  (cdr record)
	  false)))

  ;; Insert procedure
  (define (insert! key value)
    (let ((record (assoc key (cdr table))))
      (if record
	  (set-cdr! record value)
	  (set-cdr! table
		    (cons (cons key value) (cdr table)))))
    'ok)

  ;; dispatcher
  (define (dispatch op)
    (cond ((eq? op 'lookup) lookup)
	  ((eq? op 'insert!) insert!)
	  (else "UNKNOWN PROCEDURE -- " op)))

  dispatch)

(define test-table (make-table))
(define put (test-table 'insert!))
(define get (test-table 'lookup))
