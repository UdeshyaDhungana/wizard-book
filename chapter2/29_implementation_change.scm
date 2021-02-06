					;Binary mobile

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

(define (leaf? branch)
  (not (list? (cdr branch))))

					;My answer
					;I tackled this problem as a weight of a branch problem

(define (total-weight mobile)
  (define (weight-branch branch)
    (cond ((null? branch) 0)
	  ((leaf? branch) (branch-structure branch))
	  (else (total-weight (branch-structure branch)))))
  (+ (weight-branch (left-branch mobile)) (weight-branch (right-branch mobile)) ))


					;I found this on wiki, it was elegent
;Here, the problem was approached as a weight of a mobile itself
(define (total-weight-improved mobile)
  (cond ((null? mobile) 0);If it is null, 0
	((not (pair? mobile)) mobile);branch has its structure as a number or another mobile,
	;so if current mobile is not actually a mobile, but a weight, return it
	(else (+ (total-weight-improved (branch-structure (left-branch mobile)));Combine left and right weight
		 (total-weight-improved (branch-structure (right-branch mobile)))))))


(define (torque branch)
  (* (branch-length branch) (total-weight-improved (branch-structure branch))))

(define (balanced? mobile)
  (cond ( (null? mobile) #t)
	( (not (pair? mobile)) #t)
	(else (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
		   (balanced? (branch-structure (left-branch mobile)))
		   (balanced? (branch-structure (right-branch mobile)))))))


					;A good software design is made such that, on making minor changes in the implementation,
					;the codebase shouldn't change much
