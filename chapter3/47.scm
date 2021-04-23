
(define (make-semaphore n)
  (let ((count 0)
	(our-mutex (make-mutex)))
    (define (semaphore m)
      (cond ((eq? m 'acquire)
	     ;; if acqusition is required
	     (our-mutex 'acquire)
	     (if (= n count)
		 ;; limit reached
		 (begin
		   (our-mutex 'release)
		   (semaphore 'acquire))
		 ;; increase the count
		 (begin
		   (set! count (1+ count))
		   (our-mutex 'release))))
	    ;; if release is required
	    ((eq? m 'release)
	     (our-mutex 'acquire)
	     (if (zero? count)
		 ;; useless
		 (our-mutex 'release)
		 ;; one less process has acquired now
		 (begin (set! count (1- count))
			(our-mutex 'release))))))
    semaphore))

;; I ain't doing the second part. 
