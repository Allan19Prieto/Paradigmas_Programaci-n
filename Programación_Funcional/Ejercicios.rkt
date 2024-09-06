#lang scheme
;Allan Prieto Badilla 2021032988

; 3.1 Función Factorial **********************
(define (factorial n)
  (if (<= n 0)
      1
      (* n (factorial (- n 1)))
      )
  )

; 3.2 Función Fibonacci *************
(define (fibonacci n)
  ;(printf "Calculando fibonacci(~a)\n" n) ; Imprime el valor de n en cada ejecución
  (if (<= n 1)
      1
      (+ (fibonacci (- n 1))(fibonacci (- n 2)))
      )
  )

; 3.3 Función miembro ************
(define (miembro n list)
  (cond ((null? list) #f)
        ((equal? n (car list)) #t)
        (else (miembro n (cdr list)))
    )
 )

; 3.4 Función eliminar ******************
(define (eliminar n list)
  (cond ((null? list) '())
        ((equal? n (car list)) (eliminar n (cdr list)))
        (else (cons (car list) (eliminar n (cdr list))))
        )
  )

; 3.5 Función QuickSort **************
(define (quicksort lista)
  (cond ( (null? lista) '())
        ( else
          (quicksort_aux (car lista) (cdr lista) '() '()))
        )
  )
(define (quicksort_aux pivote lista menores mayores)
  (cond ( (null? lista) (append (quicksort menores) (list pivote) (quicksort mayores)))
        ( (<= (car lista) pivote) (quicksort_aux pivote (cdr lista) (cons (car lista) menores) mayores))
        ( else (quicksort_aux pivote (cdr lista) menores (cons (car lista) mayores)))
    )
  )

; 3.6 Función automovil Combina listas ***********
(define (automovil valores atributos)
  (cond ((null? valores) '())
        ((null? atributos) '())
        (else
         (cons (list(car atributos)(car valores))(automovil (cdr valores) (cdr atributos)))) 
    )
  )

;3.7 Función eliminar elemento de árbol binario *******************

; Detectar si es un átomo, es decir, no una lista
(define (atom? x)
  (not (list? x)))

; Devuelve la raíz de un árbol si es un átomo
(define (raiz arbol)
  (cond ((atom? arbol) arbol)
        (else (car arbol))))

; Devuelve el hijo izquierdo
(define (hijo-izq arbol)
  (cond ((atom? arbol) '())
        (else (cadr arbol))))

; Devuelve el hijo derecho
(define (hijo-der arbol)
  (cond ((atom? arbol) '())
        (else (caddr arbol))))

; Saca el mayor elemento del árbol
(define (mayor arbol)
  (cond ((null? arbol) #f)
        ((null? (hijo-der arbol)) (raiz arbol))
        (else (mayor (hijo-der arbol)))))

; Función para eliminar un nodo
(define (eliminar-nodo n arbol)
  (cond ((null? arbol) '())
        ; Buscamos el nodo indicado con n
        ((< n (raiz arbol))
         (list (raiz arbol)
               (eliminar-nodo n (hijo-izq arbol))
               (hijo-der arbol)))
        ((> n (raiz arbol))
         (list (raiz arbol)
               (hijo-izq arbol)
               (eliminar-nodo n (hijo-der arbol))))
        ; Nodo sin hijos
        ((and (null? (hijo-izq arbol))
              (null? (hijo-der arbol))) '())
        ; No tiene hijo izquierdo
        ((null? (hijo-izq arbol)) (hijo-der arbol))
        ; No tiene hijo derecho
        ((null? (hijo-der arbol)) (hijo-izq arbol))
        ; Nodo con dos hijos
        (else
         (list (mayor (hijo-izq arbol))
               (eliminar-nodo (mayor (hijo-izq arbol)) (hijo-izq arbol))
               (hijo-der arbol)))))

  

;3.8 Recorrer grafo usando anchura primero

; 3.9 Función Longitud
(define (longitud list)
  (cond ((null? list) 0)
        (else (+ 1 (longitud (cdr list))))
   )
  )






