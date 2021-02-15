
;; project is the opposite of raise

;; coercions can be put as

;; divide the numerator and denominator
(put-coercion 'rational 'integer (lambda (z)
				   (make-integer (round (/ (numer z) (denom z))))))


(put-coercion 'real 'rational (lambda (x)
				(make-rational (inexact->exact (numer x))
					       (inexact->exact (denom x)))))

(put-coercion 'complex 'real (lambda (z)
			       (make-real (real-part z))))

;; we do the same thing as in raise, but with the tower in opposite order
(define (project data)
  (define (seeker tower)
    (cond ((null? from-there)
	   (error "type not found in tower -- PROJECT" (list x hierarchy)))
	  ((eq? (type-tag data) (car tower))
	   (if (null? (cdr tower))
	       data			;last type in the tower, don't project it
	       (let ((projecter (get-coercion (type-tag data) (cadr types))))
		 (if projecter
		     (projecter (contents x)) ;project it
		     (error "no coercion found for types -- PROJECT" ;no coercion found
			    ;; for our integer->rational->real->complex, this branch will not be executed
			    ;; as all coercions are defined
			    (list (type-tag data) (cadr types)))))))
	  (else (seeker (cdr tower)))))
  (seeker (reverse hierarchy)))


;; and finally, the drop procedure

(define (drop z)
  (let ((dropped (project z)))
    (let ((again-raised (raise dropped)))
      (if (and (not (eq? (type-tag z) (type-tag dropped)))
	       (equ? again-raised z))
	  (drop dropped)
	  z))))
