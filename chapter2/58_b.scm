
					;So I had implemented this almost correctly,
					;Matched with wiki's answer and found a small bug
					;Here's the corrected program
(define (operation expr) 
  (if (memq '+ expr) 
      '+ 
      '*)) 

(define (sum? expr) 
  (eq? '+ (operation expr)))

					;The part before the symbol +
					;I'd forgotten that addend may be a single term, so the checking must be done

(define (addend expr) 
  (define (iter expr result) 
    (if (eq? (car expr) '+) 
        result 
        (iter (cdr expr) (append result (list (car expr))))))
  ;Here's the corrected part, for multiplication too
  (let ((result (iter expr '()))) 
    (if (= (length result) 1) 
        (car result) 
        result)))

(define (augend expr) 
  (let ((result (cdr (memq '+ expr)))) 
    (if (= (length result) 1) 
        (car result) 
        result))) 

(define (product? expr) 
  (eq? '* (operation expr)))

(define (multiplier expr) 
  (define (iter expr result) 
    (if (eq? (car expr) '*) 
        result 
        (iter (cdr expr) (append result (list (car expr)))))) 
  (let ((result (iter expr '()))) 
    (if (= (length result) 1) 
        (car result) 
        result)))

(define (multiplicand expr) 
  (let ((result (cdr (memq '* expr)))) 
    (if (= (length result) 1) 
        (car result) 
        result))) 
