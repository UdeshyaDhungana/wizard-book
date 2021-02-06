
(list 1 (list 2 (list 3 4)))

					;Tree notation

;; (list 2 (list 3 4))
;; This has a meaning
;; Make a list whose first element is a number '2'
;; Whose second element is a box pointer which points to a list with elements 3 and 4

;; (list x y)
;; Makes a pointer whose car points to x, whose cdr points to anotehr pointer, whose car points to y, and cdr to null
 ;; (1 (2 (3 4)))
 ;;      ^
 ;;    /   \
 ;;   1     ^ (2 (3 4))
 ;;       /   \
 ;;      2     ^ (3 4)
 ;;          /   \
 ;;         3     4

                                         
   ;; +---+---+  +---+---+
   ;; | * | *-+->| * | / |
   ;; +-+-+---+  +-+-+---+
   ;;   |          |   
   ;;   V          V      
   ;; +---+      +---+---+  +---+---+
   ;; | 1 |      | * | *-+->| * | / |
   ;; +---+      +-+-+---+  +---+---+
   ;;              |          |
   ;;              V          V
   ;;            +---+      +---+---+  +---+---+
   ;;            | 2 |      | * | *-+->| * | / |
   ;;            +---+      +-+-+---+  +-+-+---+
   ;;                         |          |
   ;;                         V          V
   ;;                       +---+      +---+
   ;;                       | 3 |      | 4 |
   ;;                       +---+      +---+
