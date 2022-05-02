
;; Suppose we have a Huffman tree for an alphabet of n symbols, and that the relative frequencies of the symbols are 1, 2, 4, ..., 2n-1. Sketch the tree for n=5; for n=10. In such a tree (for general n) how may bits are required to encode the most frequent symbol? the least frequent symbol?

      ;;                {a b c d e} 31
      ;;                /           \
      ;;           {a b c d} 15      e 16
      ;;            /     \
      ;;      {a b c} 7    d 8
      ;;        /    \
      ;;   {a b} 3    c 4
      ;;    /   \
      ;; a 1    b 2


;; This is the structure of the tree. For n = 10, the tree retains its structure.
;; try it out on your notebook, ain't bothering with it

;; Bits to encode most frequent symbol = 1
;; Bits to encode least frequent symbol = n-1 (Observe from the tree itself)
