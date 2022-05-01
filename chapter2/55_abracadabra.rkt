#lang racket
					;Why is it printing back quote?

(car ''abracadabra)

;; is same as (car (quote (quote abracadabra)))
;; the first quote quotes the expression that comes after it, i.e (quote abracadabra)
;; so it is equivalent to
;; (car '(quote abracadabra))
;; now it's obvious

(car '(list 'a))

;This returns 'list
