#lang racket
;; Encoding procedure

(require "huffman.rkt")

;; my implementation of encode-symbol
(define (encode-symbol char tree)
  (if (leaf? tree)
      (if (eq? char (symbol-leaf tree))
          '()
          (error "not found -- ENCODE-SYMBOL" char))
      (cond ((memq char (symbols (left-branch tree)))
             (cons '0 (encode-symbol char (left-branch tree))))
            (else (cons '1 (encode-symbol char (right-branch tree)))))))

;; encode each symbol in the message
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;; test if item is in list x
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))


;; TESTING
(define sample-tree
  (make-code-tree (make-leaf 'a 4)
                  (make-code-tree
                   (make-leaf 'b 2)
                   (make-code-tree (make-leaf 'd 1)
                                   (make-leaf 'c 1)))))

(define original '(a b b d c a b))
(define coded (encode original sample-tree))

;; (equal? (decode coded sample-tree) original) => t

;; The result is '(a b b d c a b)
(provide encode)
