
;; Infinite recursion occurs

;; In the pairs procedure provided in the text, infinit recursion does not occur
;; because the part that would cause infinite recursion is in the cdr part of stream, which is evaluated incrementally, not at once.
;; In Louis' version, it's not the case the procedure tries to compute the result recursively, but since s and t are infinite streams in the case of integers stream, maximum recursion depth is reached and procedure is aborted


