
(define sum 0)
;; sum

(define (accum x)
  (set! sum (+ x sum))
  sum)
;; accum

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
;; seq = {1 ...}

(define y (stream-filter even? seq))
;; y = {6 ...}

(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
;; z = {10 ...}

(stream-ref y 7)
;; Value 136

(display-stream z) ;; 10 ;; 15 ;; 45 ;; 55 ;; 105 ;; 120 ;; 190 ;; 210
;Value: done

;; ========================================

;; If we'd not memoized, results would be calulcated twice, so we'd get
;; different results
