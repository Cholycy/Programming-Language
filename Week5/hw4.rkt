
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (if(> low high) null
   (append (list low) (sequence (+ stride low) high stride))))


(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))


(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mode: negative number")]
  [(null? xs) (error "list-nth-mod: empty list")]
  [#t (car (list-tail xs (remainder n (length xs))))]
  ))


(define (stream-maker fn arg)
  (letrec ([f (lambda (x)
                (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f arg))))

(define ones (stream-maker (lambda (x y) 1) 1))
(define nats (stream-maker + 1))
(define powers-of-two (stream-maker * 2))


(define (stream-for-n-steps s n)
  (letrec ([f (lambda (stream lst ind)
                (let ([pr (stream)])
                  (if (>= ind n)
                      lst
                      (f (cdr pr) (append lst (list (car pr))) (+ ind 1)))))])
    (f s null 0))
)


(define funny-number-stream 
(letrec ([f (lambda (x)
              (cons (if (= 0 (remainder x 5)) (* -1 x) x) (lambda () (f (+ x 1)))))])
  (lambda () (f 1))))


(define dan-then-dog
  (letrec ([f (lambda (x)
               (cons (if (= 0 (remainder x 2)) "dog.jpg" "dan.jpg") (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))


(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))



(define (list-to-stream lst)
  (letrec ([f (lambda (cur)
                (cons (list-nth-mod lst cur) (lambda () (f (+ cur 1)))))])
    (lambda() (f 0))))
(define (stream-add s1 s2)
  (lambda() (cons (cons (car (s1)) (car (s2))) (stream-add (cdr (s1)) (cdr (s2))))))
(define (cycle-lists xs ys)
  (stream-add (list-to-stream xs) (list-to-stream ys)))


(define (vector-assoc v vec)
  (letrec ([f (lambda (cur)
                (cond [(equal? cur (vector-length vec)) #f]
                      [(and (pair? (vector-ref vec cur)) (equal? v (car (vector-ref vec cur))))(vector-ref vec cur)]
                      [ #t (f (+ cur 1))]))])
    (f 0)))


(define (cached-assoc xs n)
  (letrec([memo (make-vector n #f)]
          [pos 0]
          [f (lambda (x)
               (let ([ans (vector-assoc x memo)])
                 (if ans
                     ans
                     (let ([new-ans (assoc x xs)])
                       (if new-ans
                           (begin                   
                             (if (= pos n) (set! pos 0) pos)                          
                             (vector-set! memo pos new-ans)                          
                             (set! pos (+ 1 pos))
                             new-ans)
                           new-ans
                           )))))])
    f))
                     


(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (let ([v1 e1])
       (letrec ([loop (lambda (it)
                        (if (>= it v1)
                            #t
                            (begin (loop e2))))])
         (loop e2)))]))
     













   
