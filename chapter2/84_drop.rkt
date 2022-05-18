
;; raise one or the other

;; tower
(define hierarchy '(integer rational real complex))

;; I've implemented this for only 2 arguments
(define (apply-generic op . args)
  ;; make a function to determine highest of two types
  (define (higher a b)
    (let ((from-a (memq (type-tag a) hierarchy))
	  (from-b (memeq (type-tag b) hierarchy)))
      (if (and from-a from-b)
	  (if (> (length from-a) (length from-b))
	      b
	      a)
	  (error "one or more types not present in tower -- APPLY-GENRIC"
		 (list (map type-tag args))))))

  ;; raise a to type b successively
  ;; a and b are guarenteed to be in the tower
  (define (succ-raise a b)
    (cond ((eq? (type-tag a) (type-tag b)) a)
	  (succ-raise (raise a) b)))
  
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
	      ;; decide the higher of two types
	      (let ((higher-of-two (higher (car args) (cadr args))))
		;; if first one is higher
		(if (eq? (type-tag higher-of-two) (car type-tags))
		    ;; leave first one as it is, raise second successively until first's level
		    (op (car args) (succ-raise (cadr args) (car args)))
		    ;; vice versa
		    (op (succ-raise (car args) (cadr args)) (cadr args))))
              (error "No method for these types"
                     (list op type-tags)))))))

;; improve this
