#lang scheme
; Función Factorial
(define (factorial n)
  (if (<= n 0)
      1
      (* n (factorial (- n 1)))
      )
  )

; Función Fibonacci
(define (fibonacci n)
  ;(printf "Calculando fibonacci(~a)\n" n) ; Imprime el valor de n en cada ejecución
  (if (<= n 1)
      1
      (+ (fibonacci (- n 1))(fibonacci (- n 2)))
      )
  )