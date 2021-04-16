
;; Binary tree for the implementation of the table
(define table (cons '*table* '()))

(define (make-table)

  ;; Procedure to compare
  (define (less-than a b)
    (< a b))

  ;; Lookup procedure
  (define (assoc key records)
    (cond ((null? records) false)
	  ((equal? key (caar records)) (car records))
	  ((less-than key (caar records)) (assoc key (cadr records)))
	  (else (assoc key (caddr records)))))

  ;; Lookup procedure
  (define (lookup key)
    (let ((record (assoc key (cdr table))))
      (if record
	  (cdr record)
	  false)))

  (define (disp)
    (display table))
  ;; Insert procedure
  (define (insert! key value)
    (define (left-subtree x)
      (cadr x))
    (define (right-subtree x)
      (caddr x))
    (define (make-leaf-cell k v)
      (list (cons k v) '() '()))
    (define (helper tree parent)
      (cond ((null? tree) (set-car! parent (make-leaf-cell key value)))
	    ((less-than key (caar tree)) (helper (cadr tree) (cdr tree)))
	    ((equal? key (caar tree)) (set-cdr! (car tree) value))
	    (else (helper (caddr tree) (cddr tree)))))
    (if (null? (cdr table))
	(set-cdr! table (make-leaf-cell key value))
	(helper (cdr table) '()))
    'done)


  ;; dispatcher
  (define (dispatch op)
    (cond ((eq? op 'lookup) lookup)
	  ((eq? op 'insert!) insert!)
	  ((eq? op 'disp) (disp))
	  (else "UNKNOWN PROCEDURE -- " op)))

  dispatch)

(define test-table (make-table))
(define put (test-table 'insert!))
(define get (test-table 'lookup))
(define (disp)
  (test-table 'disp))
