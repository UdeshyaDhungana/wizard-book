#lang racket
;; Using Huffman tree to encode Rock songs!

;; to generate huffman tree
(require "./69_successive_merge.rkt")
;; for encode function
(require "./68_encode_symbol.rkt")

;; for decode function
(require "./huffman.rkt")

(define freq-pair '((a 2)
					(na 16)
					(boom 1)
					(sha 3)
					(get 2)
					(yip 9)
					(job 2)
					(wah 1)))

(define rock-tree (generate-huffman-tree freq-pair))

(define rock-song '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom))

(define encoded-rock-song (encode rock-song rock-tree))

;; (decode encoded-rock-song rock-tree) => works

;; Length of encoded string = 84
;; Smallest number of bit needed to encode = 3 * (length rock-song) = 3 * 36 = 108
;; 3 bit because there are 8 symbols in freq-pair
