
;Procedure 'reverse' using accumulate (fold-right) and fold-left

					;Dependencies

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (reverse sequence)
  (accumulate (lambda (first result) (append result (list first))) () sequence))

(define (reverse-fold sequence)
  (fold-left (lambda (result first) (cons first result)) () sequence))
