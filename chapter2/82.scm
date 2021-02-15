
;; returns false if any element in a sequence is false
(define (any-false? seq)
  (cond ((null? seq) #f)
	((not (car seq)) #t)
	(else (any-false? (cdr seq)))))

;; produce coerced arguments
(define (produce-coercion type-tags args)
  (define (iter tags)			;A function to iterate over type of tags
    (if (null? tags)
	false				;no coercion possible
	(let ((current-tag (car tags)))	;current tag that all other types should be coerced into
	  (let ((coercions		;possible coercions
		 (map (lambda (from)
			(if (eq? from current-tag)
			    (lambda (z) z)) ;to prevent same type coercion
			(get-coercion from current-tag)
			type-tags))))
	    (if (any-false? coercions)	;if any false on coercions exist, loop over cdr of tags
		(iter (cdr tags))
		(map (lambda (coercion arg) ;apply coercion function to each args
		       (coercion arg))
		     coercions
		     args))))
  (iter type-tags))))


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args)) ;apply the process if it is found for same type
          (let ((coerced-arguments (produce-coercion type-tags args))) ;produced the list of coerced arguments
	    (if coerced-arguments
		;; get the type tags of coerced arguments, and then search for entry in table
		(let ((coerced-type-tags (map type-tag coerced-arguments)))
		  (let ((applicable-function (get op coerced-type-tags)))
		    (apply applicable-function (map contents coerced-arguments)))))
		(error "no method for these types" (list op type-tags))))))))



;; This is fail whenever, let's say we have an operation on types
;; (a b b) and our arguments are of type (a b c), any coercion will not produce
;; (a b b) because all elements must be same type in coercion. So this will fail

;; Two argument will fail on any operation with 3 or more arguments+
