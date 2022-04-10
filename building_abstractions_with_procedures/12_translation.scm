;Pascal's Triangle

(define (pascal row column)
  ;Assumes valid value for row and column
  (if (or (= column 1) (= row column))
    1
    (+ (pascal (- row 1) (- column 1)) (pascal (- row 1) column))))


(pascal 5 3)
