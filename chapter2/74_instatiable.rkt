;; Insatiable Enterprises' Program

;; Let the salary across different branch for a particular post is same
;; This is just for an example, we can make this unique for each branch
;; We're doing this just for the sake of simplicity

(define posts '((branch-manager . 100)
                 (hr . 80)
                 (accountant . '75)
                 (officer . 70)
                 (clerk . 60)))

(define (get-salary-from-post post)
  (define (seek current-data)
    (cond ((null? current-data)
           (error "no post found -- GET-SALARY-FROM-POST" post))
          ((eq? (caar current-data) post) (cdar current-data))
          (else (seek (cdr current-data)))))
  (seek posts))

(define (get-post-from-salary salary)
  (define (seek current-data)
    (cond ((null? current-data)
           (error "no post found -- GET-POST-FROM-SALARY" salary))
          ((= (cdar current-data) salary) (caar current-data))
          (else (seek (cdr current-data)))))
  (seek posts))


(define current-year 2021)
(define (get-since-from-experience experience)
  (- current-year experience))
(define (get-experience-from-since since)
  (- current-year since))

;; Let's put a tagging system

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

;; Imagine a branch where the data is indexed on the basis of employee's names
;; Also, the other records stored are employee number, salary, and experience


(define (install-biratnagar-branch-package)
  (define (name person)
    (car person))

  (define (id person)
    (cadr person))

  (define (salary person)
    (caddr person))

  (define (experience person)
    (caddr person))

  (define (post person)
    (get-post-from-salary (salary person)))

  (define (working-since person)
    (get-since-from-experience (experience person)))

  (define (make-from-salary-experience name id salary experience)
    (list name id salary experience))

  (define (make-from-post-start_date name id post start_date)
    (list name
          id
          (get-salary-from-post post)
          (get-experience-from-since start_date)))

  (define (get-from-database person)
    (retrieve (name person)))
  ;; retrieve is a function that retrieves the person details
  ;; In this branch, database is indexed by person's name

  ;; interface to the outer system
  (define (tag x) (attach-tag 'biratnagar x))

  (put 'name '(biratnagar) name)
  (put 'id '(biratnagar) id)
  (put 'salary '(biratnagar) salary)
  (put 'experience '(biratnagar) experience)
  (put 'post '(biratnagar) post)
  (put 'working-since '(biratangar) working-since)
  (put 'make-from-salary-experience 'biratnagar
       (lambda (n i s e) (tag (make-from-salary-experience n i s e))))
  (put 'make-from-post-start_date 'biratnagar
       (lambda (n i p s) (tag (make-from-post-start_date n i p s))))
  (put 'get-from-database '(biratnagar) get-from-database)
  'done)


;; Another branch, here
(define (install-kathmandu-branch-package)
  (define (name person)
    (car person))

  (define (id person)
    (cadr person))

  (define (salary person)
    (get-salary-from-post (post person)))

  (define (experience person)
    (get-experience-from-since (working-since person)))

  (define (post person)
    (caddr person))

  (define (working-since person)
    (cadddr person))

  (define (make-from-salary-experience name id salary experience)
    (list name
          id
          (get-post-from-salary salary)
          (get-since-from-experience experience)))

  (define (make-from-post-start_date name id post start_date)
    (list name id post start_date))

  (define (get-from-database person)
    (retrieve (id person)))
  ;; retrieve is a function that retrieves the person details
  ;; In this branch, we index using employee id

  ;; interface to the outer system
  (define (tag x) (attach-tag 'kathmandu x))

  (put 'name '(kathmandu) name)
  (put 'id '(kathmandu) id)
  (put 'salary '(kathmandu) salary)
  (put 'experience '(kathmandu) experience)
  (put 'post '(kathmandu) post)
  (put 'working-since '(kathmandu) working-since)
  (put 'make-from-salary-experience 'kathmandu
       (lambda (n i s e) (tag (make-from-salary-experience n i s e))))
  (put 'make-from-post-start_date 'kathmandu
       (lambda (n i p s) (tag (make-from-post-start_date n i p s))))
  (put 'get-from-database '(kathmandu) get-from-database)
  'done)

;; Generic functions
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types -- APPLY-GENERIC"
           (list op type-tags))))))


(define (name emp) (apply-generic 'name emp))
(define (id emp) (apply-generic 'id emp))
;; Answer
(define (get-salary emp) (apply-generic 'salary emp))
(define (get-record emp) (apply-generic 'get-from-database emp))

(define (experience emp) (apply-generic 'experience emp))
(define (working-since emp) (apply-generic 'working-since emp))

;; On taking over a new company, its respective branch package should be installed

;; ------------------------------------------------------------

;; Englilsh is not my mother tongue. I may not have understood the question clearly.
;; Email me if you find errors in my understanding of this question.
