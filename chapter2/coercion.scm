
;; What we've done so far is introduced operations that work on data of same data type
;; For example we could add a complex number to another, but we couldn't add, say,
;; a complex number to a rational number. We want to implement such a feature. One way
;; to do it as follows

;; to be included in the complex package
(define (add-complex-to-schemenum z x)
  (make-from-real-imag (+ (real-part z) x)
                       (imag-part z)))
(put 'add '(complex scheme-number)
     (lambda (z x) (tag (add-complex-to-schemenum z x))))

;; It's cumbersome. Because, the cost of adding new data type is the implementation of the
;; functions of that type, as well as some functions that work on data of different types.
;; But the problem with, let's say we want to construct a operation add complex number to
;; rational, where should the function add-complex-to-rational be? Should it belong to
;; rational package or the complex numebr package?

;; A good way to tackle this problem is the use of what's called coercion

;;  Often the different data types are not completely independent
;; and there may be ways by which objects of one type may be viewed
;; as being of another type. This process is called coercion.


;; Let put-coercion and get-coercion be two procedures with the help of which we can
;; put coercion between different types on a table.

;; This function converts a scheme number to a complex number
(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))

;; We install this using the function
(put-coercion 'scheme-number 'complex scheme-number->complex)
;; Most of the entries in the table will be empty because conversion between most data types
;; is not that easy. Even complex->scheme-number doesn't exist (Think it for yourself!)

;; We need to change the apply-generic procedure a bit
;; Let's assume the case where there are only two arguments

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args)) ;apply the process if it is found for same type
          (if (= (length args) 2)	   
              (let ((type1 (car type-tags)) 
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2		;if t1->t2 exists, i.e. coercion from type1 to type2 exists,
			 ;; then we coerce from type1 to 2 and apply generic to the converted object
			 ;; and the remaining object
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types"
                                (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))
 
