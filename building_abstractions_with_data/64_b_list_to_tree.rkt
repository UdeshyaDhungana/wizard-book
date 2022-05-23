#lang racket

;; The tree produced by this algorithm for the list (1 3 5 7 9 11) is

 ;;   5
 ;; 1     9
 ;;  3  7  11

;; T(n) = 2 * T(n/2) + Θ(1)

;;It takes Θ(n) time
