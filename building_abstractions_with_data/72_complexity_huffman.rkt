
;; encode-symbol is given as T(n) = T(n/2) [subtree] + Θ(n) [searching in node]
;; It's given as Θ(n · log(n))

;; Special case
;; Encoding most frequent symbol is given as
;; Θ(n) [searching in node list] + Θ(1) [immediately on left/right branch]
;; Effective complexity = Θ(n)

;; Encoding least frequent symbol
;; T(n) = T(n-1) [Only one node is cleared] + Θ(n) [searching in node list]
;; Effective complexity = Θ(n²)

;; These two are the bounds for complexity for a general Huffman treex
