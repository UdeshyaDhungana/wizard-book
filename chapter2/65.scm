
;; Union and Intersection of sets in Θ(n)

;; Load dependencies
(load "63")
(load "64")

;; Given two ordered lists, produces the union of them
;; Takes Θ(n) time

(define (union-list a b)
  (cond ((null? a) b)
	((null? b) a)
   (else (let ((x1 (car a))
	 (x2 (car b)))
     (cond ((= x1 x2) (cons x1 (union-list (cdr a) (cdr b))))
	   ((> x1 x2) (cons x2 (union-list a (cdr b))))
	   (else (cons x1 (union-list (cdr a) b))))))))


;; Union of two sets
(define (union-set s1 s2)
  (let ((s1-ordered-list (tree->list-2 s1))
	(s2-ordered-list (tree->list-2 s2)))
    (let ((merged-list (union-list s1-ordered-list
				   s2-ordered-list)))
      (list->tree merged-list))))

;; T(n) = Θ(n) * 2 [Converting to list] + Θ(n) [Union of lists] + Θ(n) [List to tree]


(define (intersection-list set1 set2)
  (if (or (null? set1) (null? set2))
      '()    
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-list (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-list (cdr set1) set2))
              ((< x2 x1)
               (intersection-list set1 (cdr set2)))))))


;; Intersection of two sets
(define (intersection-set s1 s2)
  (let ((s1-ordered-list (tree->list-2 s1))
	(s2-ordered-list (tree->list-2 s2)))
    (let ((merged-list (intersection-list s1-ordered-list
				   s2-ordered-list)))
      (list->tree merged-list))))

;; T(n) = Θ(n) * 2 [Converting to list] + Θ(n) [Intersection of lists] + Θ(n) [List to tree]
