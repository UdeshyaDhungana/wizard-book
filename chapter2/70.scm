
;; Using Huffman tree to encode Rock songs!

;; All dependencies are here
(load "69")

(define freq-pair '((a 2)
		    (na 16)
		    (boom 1)
		    (sha 3)
		    (get 2)
		    (yip 9)
		    (job 2)
		    (wah 1)))



(define rock-tree (generate-huffman-tree freq-pair))

(define rock-song '(Get a job Sha na na na na na na na na Get a job Sha na na na na na na na na Wah yip yip yip yip yip yip yip yip yip Sha boom))

(define encoded-rock-song (encode rock-song rock-tree))

;; Length of encoded string = 84
;; Smallest number of bit needed to encode = 3 * (length rock-song) = 3 * 36 = 108
;; 3 bit because there are 8 symbols in freq-pair
