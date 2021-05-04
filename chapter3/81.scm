
(define (random-number-generator command-stream)
  ;; if first command is reset, begin with that number
  ;; otherwise start with random init and continue with the
  ;; request stream
  (let ((req (stream-car command-stream)))
    (let ((first (if (eq? 'reset (car req))
			   (cadr req)
			   random-init))
	  (request-stream (if (eq? 'reset (car req))
			      (stream-cdr request-stream)
			      request-stream)))
  (define random-number
    (cons-stream random-init
		 (stream-map (lambda(number command)
			       (cond ((null? command) '())
			       ((eq? command 'generate)
				(random-update number))
			       ((and (pair? command)
				     (eq? (car command) 'reset))
				(cdr command))
			       (else
				(error "bad command --" command))))
			     random-number
			     command-stream)))
  random-number)))
