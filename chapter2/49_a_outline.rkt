#lang racket

(require sicp-pict)

(define origin (make-vect 0 0))
(define i-hat (make-vect 1 0))
(define j-hat (make-vect 0 1))
(define corner (make-vect 1 1))

(define seg1 (make-segment origin i-hat))
(define seg2 (make-segment i-hat corner))
(define seg3 (make-segment corner j-hat))
(define seg4 (make-segment j-hat origin))
(define all-segments (list seg1 seg2 seg3 seg4))

(define outline-painter (segments->painter all-segments))

(paint outline-painter)
