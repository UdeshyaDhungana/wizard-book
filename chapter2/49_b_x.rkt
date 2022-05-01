#lang racket

(require sicp-pict)

;The painter that draws an X

(define origin (make-vect 0 0))
(define i-hat (make-vect 1 0))
(define j-hat (make-vect 0 1))
(define corner (vector-add i-hat j-hat))

(define diag1 (make-segment j-hat i-hat))
(define diag2 (make-segment origin corner))

(define x-painter (segments->painter (list diag1 diag2)))

(paint x-painter)
