#lang racket
;; Monte carlo simulation

;; this function returns a random number between low and high
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

;; higher order monte-carlo
(define (monte-carlo num-trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed num-trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter num-trials 0))


(define (estimate-integral predicate x-lower x-upper y-lower y-upper num-trials)
  (define (lies-inside?)
    ;; Generate random pair
    ;; Test it with predicate
    (predicate (random-in-range x-lower x-upper)
       (random-in-range y-lower y-upper)))
  (monte-carlo num-trials lies-inside?))


(define (estimate-pi)
  (* 4 (estimate-integral (lambda (x y)
                       (<= (+ (sqr (- x 0)) (sqr (- y 0))) (sqr 1000)))
                     -1000
                     1000
                     -1000
                     1000
                     10000.0)))

(estimate-pi)
