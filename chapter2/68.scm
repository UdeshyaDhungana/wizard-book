
;; Encoding procedure

(load "huffman.scm")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(define (encode-symbol char tree)
  (if (leaf? tree)
      (if (eq? char (symbol-leaf tree))
	  '()
	  (error "not found -- ENCODE-SYMBOL" char))
      (cond ((memq char (symbols (left-branch tree)))
	     (cons '0 (encode-symbol char (left-branch tree))))
	    (else (cons '1 (encode-symbol char (right-branch tree)))))))

;; TESTING IF IT WORKS

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define coded (encode '(a b b d c a b) sample-tree))

(decode coded sample-tree)

;; The result is '(a b b d c a b)


