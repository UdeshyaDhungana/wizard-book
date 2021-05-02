
;; import stream_deps.scm before this file
;; import 66.scm before this file

(define (triplets s t u)
  ;; take first element from each stream
  (cons-stream (list (stream-car s)
		     (stream-car t)
		     (stream-car u))
	       (interleave
		;; join first element of s with every combination of t and u
		(stream-map (lambda(x) (cons (stream-car s) x)) (stream-cdr (pairs t u)))
		;; do it recursively for the rest of the stream
		(triplets (stream-cdr s)
			  (stream-cdr t)
			  (stream-cdr u)))))

;; pick those which satisfy pythagorean theorem
(define pythagoras-triplets
  (stream-filter (lambda(t)
		   (= (square (caddr t)) (+ (square (car t)) (square (cadr t)))))
		 (triplets integers integers integers)))
