
;; Raising the type

(define hierarchy '(integer rational real complex))

;; This function raises the given argument to next data type in hierarchy
;; if not possible, it returns false
(define (raise data)
  (define (seeker tower)
    (cond ((null? from-there)
	   (error "type not found in tower -- RAISE" (list x hierarchy)))
	  ((eq? (type-tag data) (car tower))
	   (if (null? (cdr tower))
	       data			;last type in the tower, don't raise it
	       (let ((raiser (get-coercion (type-tag data) (cadr types))))
		 (if raiser
		     (raiser (contents x)) ;raise it
		     (error "no coercion found for types -- RAISE" ;no coercion found
			    ;; for our integer->rational->real->complex, this branch will not be executed
			    ;; as all coercions are defined
			    (list (type-tag data) (cadr types)))))))
	  (else (seeker (cdr tower)))))
  (seeker hierarchy))
