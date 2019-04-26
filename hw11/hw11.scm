(define (find s predicate)
(cond
    ((eq? s nil) #f)
    ((predicate (car s)) (car s))
    (else (find (cdr-stream s) predicate))
)
)


(define (scale-stream s k)
(cond
  ((eq? s nil) s)
  (else (cons-stream (* k (car s)) (scale-stream (cdr-stream s) k)))
)
)
(define (has-cycle-helper low-ls high-ls)
  (cond
   ((null? high-ls) #f)
   ((null? (cdr-stream high-ls)) #f)
   ((eq? low-ls high-ls) #t)
   (else (has-cycle-helper (cdr-stream low-ls) (cdr-stream (cdr-stream high-ls))))
  )
)

(define (has-cycle s)
  (cond
    ((null? s) #f)
    (else (has-cycle-helper s (cdr-stream s)))
  )
)

(define (has-cycle-constant s)
  'YOUR-CODE-HERE
)
