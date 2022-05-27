
;; So this requires me drawing a ton of diagrams. And my exams are coming soon!
;; So, I did this in my notebook and verified it using sicp wiki. It matched, here's the solution

;; (define acc (make-account 50))

;; global   _________________________________
;; env  -->| make-account :*                 |
;;         | acc : *       |                 |
;;          -------|-------|---^-----------^-
;;                 |       |   |           |
;;                 |     ( * , * )         |
;;                 |       |               |
;;                         parameter: balance
;;                 |       body: (define (withdraw ... ))
;;                 |                       |
;;                 |                -------Frame 0-      (parameter, body)
;;                 |               | balance  : 50 |      |
;;                 |           E0->| withdraw : *--|--> ( * , * )  
;;                 |               | deposit  : *--|--> ( * , * ) 
;;                 |               | dispatch : *--|--> ( * , * )     
;;                 |                -------^----^--           |
;;                 |    ___________________|    |_____________| 
;;                 |   |
;;               ( * , * )
;;                 |
;;                 parameter : m           
;;                 body      : (cond ((eq? m ... )))               

;; ((acc 'deposit) 40)

;; Frame 1 is created when (acc 'deposit is evaluated).
;; Next, Frame 2 is created when (deposit amount). Since deposit is defined
;; in E0, Frame 2 pointer is to environment E0.

;; global   _________________________________
;; env  -->| make-account :*                 |
;;         | acc : *                         |
;;          -------|-----------------------^-
;;                 |                       |
;;                 |                -------Frame 0-
;;                 |               | balance  : 50 |
;;               ( *, *-)--------->| withdraw : *  |
;;                                 | deposit  : *  |<- E0
;;                                 | dispatch : *  |
;;                                  -^-----^------- (make-account balance)
;;                          _________|     |
;;                         |        -------Frame 1-
;;                         |       | m : 'deposit  |<- E1 
;;                         |        --------------- (dispatch m)
;;                  -------Frame 2-
;;                 | amount : 40   |<- E2
;;                  --------------- (deposit amount)

;; After ((acc 'deposit) 40) evaluation balance is set to 90 in Frame 0 and
;; Frames 1 and 2 are not relevant anymore.

;; global   _________________________________
;; env  -->| make-account :*                 |
;;         | acc : *                         |
;;          -------|-----------------------^-
;;                 |                       |
;;                 |                -------Frame 0-
;;                 |               | balance  : 90 |
;;               ( *, *-)--------->| withdraw : *  |
;;                                 | deposit  : *  |<- E0
;;                                 | dispatch : *  |
;;                                  --------------- 

;; ((acc 'withdraw) 60)

;; global   _________________________________
;; env  -->| make-account :*                 |
;;         | acc : *                         |
;;          -------|-----------------------^-
;;                 |                       |
;;                 |                -------Frame 0-
;;                 |               | balance  : 90 |
;;               ( *, *-)--------->| withdraw : *  |
;;                                 | deposit  : *  |<- E0
;;                                 | dispatch : *  |
;;                                  -^-----^------- (make-account balance)
;;                          _________|     |
;;                         |        -------Frame 3-
;;                         |       | m : 'withdraw |<- E3
;;                         |        --------------- (dispatch m)
;;                  -------Frame 4-
;;                 | amount : 60   |<- E4
;;                  --------------- (withdraw amount)

;; After ((acc 'withdraw) 60)

;; global   _________________________________
;; env  -->| make-account :*                 |
;;         | acc : *                         |
;;          -------|-----------------------^-
;;                 |                       |
;;                 |                -------Frame 0-
;;                 |               | balance  : 30 |
;;               ( *, *-)--------->| withdraw : *  |
;;                                 | deposit  : *  |<- E0
;;                                 | dispatch : *  |
;;                                  ---------------


;; So something like this happens.
;; When you define a procedure, a pointer from variable in the global environment to the code,pointer pair
;; is constructed, where the pointer in the pair points back to the global environment

;; When the procedure is evaluated, a new environment is created where the formal parameter has the value
;; of argument

;; If the procedure is defined


;; If another account, namely acc is made, it has its own local state
;; The only shared environment between two is the global environment
