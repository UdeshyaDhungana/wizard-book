
;; For the object in figure 2.24, its type is 'complex .
;; To find the real part of a type complex, we invoke



;; Let's all recall how (magnitude z) is called
;; (define (magnitude z) (apply-generic 'magnitude z))

;; Here, apply-generic is called for the function 'magnitude on the datum z
;; It's type is '(complex), so adding Alyssa's code will invoke the function that will
;; dispatch the type '(complex) and call the magnitude function defined in
;; complex_final.scm. Then the operation will be continued as it were in complex_final.scm

;; (magnitude z)

;; (apply-generic 'magnitude z)
;; This will get a function from table 'magnitude that acts on type complex, because
;; the data type of z is 'complex for this level
;; Now, that function will invoke 'magnitude function in complex_final.scm
;; This time, again apply-generic will be called, but the data type is rectangular (because
;; last call on apply-geric strips off the type on that level and now the type of datum becomes
;; rectangular). Now the magnitude function for 'rectangular is called, which is a function that
;; returns the square root of the sum of squares of x and y coordinates. In this way, the function
;; (magnitude z) is evaluated :)

;; apply-generic is invoked twice

;; In the first case, it is dispatched to the function in the table that acts on complex type,
;; which is the magnitude function defined in complex_final.scm, and on the second turn, it is dispatched
;; to the magnitude function inside the rectangular package
