
;; Designing a generic system

;; these were implemented in derivative.scm
(define (variable? x)
  (symbol? x))

(define (same-variable? x y)
  (and (variable? x) (variable y) (eq? x y)))


(define (install-dense-term-package)
  ;; internal procedures
   (define (adjoin-term term term-list) 
   (cond ((=zero? term) term-list) 
         ((=equ? (order term) (length term-list)) (cons (coeff term) term-list)) 
         (else (adjoin-term term (cons 0 term-list)))))

   (define (first-term termlist)
     (make-term (- (length termlist) 1) (car termlist)))

   (define (rest-terms termlist)
     (cdr termlist))

   ;; interface
   (define (tag x) (attach-tag 'dense x))
   (put 'adjoin-term 'dense adjoin-term) ;we only adjoin one item, so need for list structure

   (put 'first-term '(dense) first-term)
   (put 'rest-terms '(dense) rest-terms))

(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term term-list))

(define (first-term termlist)
  (apply-generic 'first-term termlist))

(define (rest-terms termlist)
  (apply-generic 'rest-terms termlist))
