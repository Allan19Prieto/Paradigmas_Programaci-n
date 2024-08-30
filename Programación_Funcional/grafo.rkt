#lang scheme
;grafo
; Definición de un grafo como una lista de adyacencia
(define graph
  '((A . (B C))
    (B . (A D E))
    (C . (A F))
    (D . (B))
    (E . (B F))
    (F . (C E))))

; Función para obtener los vecinos de un nodo
(define (neighbors node graph)
  (cond
    ((null? graph) '())
    ((equal? (car (car graph)) node) (cdr (car graph)))
    (else (neighbors node (cdr graph)))))

; BFS: Búsqueda en anchura
(define (bfs graph start)
  (let loop ((queue (list start)) ; Cola para los nodos a visitar
             (visited '()))        ; Lista de nodos ya visitados
    (cond
      ((null? queue) visited)      ; Si la cola está vacía, hemos terminado
      (else
       (let ((current (car queue))  ; Nodo actual
             (rest (cdr queue)))    ; Resto de la cola
         (if (member current visited) ; Si ya fue visitado, continuar
             (loop rest visited)
             (loop (append rest (neighbors current graph)) ; Añadir vecinos a la cola
                   (cons current visited)))))))) ; Marcar como visitado

; Ejemplo de uso
(bfs graph 'A) ; Comenzando desde el nodo A
