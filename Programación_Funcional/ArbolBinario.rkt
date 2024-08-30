#lang scheme
;Arbol Binario
; Definición árbol binario



(define (make-node value left right)
  (list value left right))

(define (node-value node) (car node))
(define (left-child node) (cadr node))
(define (right-child node) (caddr node))

; Función para encontrar el sucesor in-order (el nodo más pequeño en el subárbol derecho)
(define (min-value-node node)
  (if (null? (left-child node))
      node
      (min-value-node (left-child node))))

; Función para eliminar un nodo de un árbol binario de forma funcional
(define (delete-node tree value)
  (cond
    ((null? tree) '()) ; Caso base: árbol vacío
    ((< value (node-value tree)) ; El valor está en el subárbol izquierdo
     (make-node (node-value tree)
                (delete-node (left-child tree) value)
                (right-child tree)))
    ((> value (node-value tree)) ; El valor está en el subárbol derecho
     (make-node (node-value tree)
                (left-child tree)
                (delete-node (right-child tree) value)))
    (else
     (let* ((left (left-child tree))
            (right (right-child tree)))
       (cond
         ; Caso 1: Nodo sin hijos
         ((and (null? left) (null? right)) '())
         ; Caso 2: Nodo con un solo hijo (derecho o izquierdo)
         ((null? left) right)
         ((null? right) left)
         ; Caso 3: Nodo con dos hijos
         (else
          (let ((successor (min-value-node right)))
            (make-node (node-value successor)
                       left
                       (delete-node right (node-value successor))))))))))

; Ejemplo de uso
(define tree
  (make-node 5
             (make-node 3
                        (make-node 2 '() '())
                        (make-node 4 '() '()))
             (make-node 7
                        (make-node 6 '() '())
                        (make-node 8 '() '()))))

; Prueba de eliminación
(delete-node tree 7)

