#lang scheme
; Quick sort
(define (quicksort lst)
  (cond
    ((null? lst) '()) ; Caso base: lista vacía
    (else
      (let* ((pivot (car lst))
             (rest (cdr lst))
             (less (filter (lambda (x) (<= x pivot)) rest))
             (greater (filter (lambda (x) (> x pivot)) rest)))
        (append (quicksort less) (cons pivot (quicksort greater)))))))

(define (filter pred lst)
  (cond
    ((null? lst) '())
    ((pred (car lst)) (cons (car lst) (filter pred (cdr lst))))
    (else (filter pred (cdr lst)))))

 