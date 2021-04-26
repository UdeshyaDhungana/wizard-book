
;; Stream map procedure

;; One that works on only one
(define (stream-map-one proc stream)
  (if (stream-null? stream)
      the-empty-stream
      (cons-stream (proc (stream-car stream))
		   (stream-map-one proc (stream-cdr stream)))))

;; A version that works on multiple streams
(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
	      (cons proc (map stream-cdr argstreams))))))
