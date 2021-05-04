
;; solving a general 2nd order ODE using streams
;; include 78.scm before this

(define (solve-2nd derivative y0 dy0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  ;; assuming derivative is a function of dy/dt and y
  ;; as per the text
  (define ddy (stream-map derivative dy y))
  y)
