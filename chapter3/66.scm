
(define (interleave s1 s2)
(if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
		 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

;; 197 pairs precede (1,100)

;; 1 2 4 6 8 10 12 ...
;;   3 5 9 13 17 21 ...
;;     7 11 19 27 35 ...
;;       15 23 39 ...
;;          31 ...

;; f(i,j) = 2^i - 2, i = j
;; f(i,j) = 2^i * (j-i) + 2^(i-1) - 2, i < j
