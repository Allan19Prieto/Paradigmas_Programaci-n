#lang scheme

;; Representación del tablero
;(define empty-board '((#f #f #f) (#f #f #f) (#f #f #f)))

; Función para crear una matriz del tamaño n por n
(define (empty-board fila columna)
  (cond ((or (zero? fila) (zero? columna)) '())
        ((or (> fila 10) (> columna 10)) '())
        (else (tablero-aux fila columna))
        )
  )

; Crea una matriz añadiendo las columnas en cada fila
(define (tablero-aux fila columna)
  (cond ((zero? fila) '())
        ;(else (cons (make-list columna #f) (tablero-aux (- fila 1) columna)))
        (else (cons (make-list columna #f) (tablero-aux (- fila 1) columna)))
        )
  )

;; Función para verificar si una celda está vacía
(define (is-empty? cell)
  (equal? cell #f))

;; Obtener lista de celdas vacías
(define (empty-cells board)
  (for*/list ([i (in-range (length board))]
              [j (in-range (length board))]
              #:when (is-empty? (list-ref (list-ref board i) j)))
    (list i j)))

;; Función para actualizar una lista en una posición específica
(define (update-list lst index new-value)
  (append (take lst index) (list new-value) (drop lst (+ index 1))))

;; Actualizar el tablero con una nueva jugada
#|
  (define (make-move board move player)
  (let* ([row (list-ref board (first move))]
         [new-row (update-list row (second move) player)])
    (update-list board (first move) new-row)))
|#
(define (make-move board move player)
  (update-list board
               (first move)
               (update-list (list-ref board (first move))
                            (second move)
                            player)))

;; Verificar si una fila es ganadora

(define (check-row? board player row)
  (define (has-three-consecutive? lst)
    (define len (length lst))
    (define (check-at index)
      (and (< index (- len 2))
           (equal? (list-ref lst index) player)
           (equal? (list-ref lst (+ index 1)) player)
           (equal? (list-ref lst (+ index 2)) player)))
    (define (check-sequences index)
      (cond
        [(>= index (- len 2)) #f] ; Si el índice supera el rango válido, retorna #f
        [(check-at index) #t]    ; Si hay una secuencia de tres iguales, retorna #t
        [else (check-sequences (+ index 1))])) ; Continua verificando el siguiente índice
    (check-sequences 0)) ; Inicia la verificación desde el índice 0
  (has-three-consecutive? (list-ref board row)))



;; Verificar si una columna es ganadora
(define (check-column? board player column)

  ;; Función para obtener los valores de una columna
  (define (obtener-valores-columna filas columna index acc)
    (if (null? filas)
        (reverse acc)
        (obtener-valores-columna (cdr filas) columna (+ index 1) (cons (list-ref (car filas) columna) acc))))
  
  (define (has-three-consecutive? lst)
    (define len (length lst))
    (define (check-at index)
      (and (< index (- len 2))
           (equal? (list-ref lst index) player)
           (equal? (list-ref lst (+ index 1)) player)
           (equal? (list-ref lst (+ index 2)) player)))
    (define (check-sequences index)
      (cond
        [(>= index (- len 2)) #f] ; Si el índice supera el rango válido, retorna #f
        [(check-at index) #t]    ; Si hay una secuencia de tres iguales, retorna #t
        [else (check-sequences (+ index 1))])) ; Continua verificando el siguiente índice
    (check-sequences 0)) ; Inicia la verificación desde el índice 0
  
  
  ;; Obtiene los valores de la columna deseada
  (define column-values
    (obtener-valores-columna board column 0 '()))
  
  (has-three-consecutive? column-values))


;; Verificar si alguna diagonal es ganadora
(define (check-diagonals? board player)
  (define (has-three-consecutive? lst)
    (define len (length lst))
    (define (check-sequences index)
      (cond
        [(>= index (- len 2)) #f]
        [(and (equal? (list-ref lst index) player)
              (equal? (list-ref lst (+ index 1)) player)
              (equal? (list-ref lst (+ index 2)) player)) #t]
        [else (check-sequences (+ index 1))]))
    (check-sequences 0))
  
  (define (check-main-diagonals row col)
    (cond
      [(>= row (length board)) #f]
      [(>= col (length (list-ref board row))) (check-main-diagonals (+ row 1) 0)]
      [else
       (define diagonal (check-diagonal board row col 1 1 '()))
       (if (has-three-consecutive? diagonal)
           #t
           (check-main-diagonals row (+ col 1)))]))
  
  (define (check-secondary-diagonals row col)
    (cond
      [(>= row (length board)) #f]
      [(< col 0) (check-secondary-diagonals (+ row 1) (- (length (list-ref board 0)) 1))]
      [else
       (define diagonal (check-diagonal board row col 1 -1 '()))
       (if (has-three-consecutive? diagonal)
           #t
           (check-secondary-diagonals row (- col 1)))]))
  
  (define (check-diagonal board start-row start-col row-step col-step diagonal)
    (if (or (>= start-row (length board)) (< start-col 0) (>= start-col (length (list-ref board 0))))
        (reverse diagonal)
        (check-diagonal board (+ start-row row-step) (+ start-col col-step) row-step col-step (cons (list-ref (list-ref board start-row) start-col) diagonal))))
  
  (or (check-main-diagonals 0 0)
      (check-secondary-diagonals 0 (- (length (list-ref board 0)) 1))))

;***************


;; Verificar si un movimiento es ganador
(define (winning-move? board player move)
  (let ([new-board (make-move board move player)])
    (or (check-row? new-board player (first move))
        (check-column? new-board player (second move))
        (check-diagonals? new-board player))))

;; Buscar la jugada ganadora para un jugador
(define (find-winning-move board player)
  (findf (lambda (move) (winning-move? board player move))
         (empty-cells board)))

;; Determinar la mejor jugada usando el algoritmo voraz
(define (best-move board player)
  (define opponent (if (equal? player 'O) 'X 'O))
  
  (cond
    ;; Buscar movimiento ganador
    [(find-winning-move board player) => (lambda (move) move)]
    ;; Bloquear movimiento ganador del oponente
    [(find-winning-move board opponent) => (lambda (move) move)]
    ;; Ocupar el centro
    [(is-empty? (list-ref (list-ref board 1) 1)) '(1 1)]
    ;; Ocupar una esquina
    [(is-empty? (list-ref (list-ref board 0) 0)) '(0 0)]
    [(is-empty? (list-ref (list-ref board 0) 2)) '(0 2)]
    [(is-empty? (list-ref (list-ref board 2) 0)) '(2 0)]
    [(is-empty? (list-ref (list-ref board 2) 2)) '(2 2)]
    ;; Tomar cualquier casilla vacía
    [else (first (empty-cells board))]))

;; Mostrar el tablero
(define (display-board board)
  (for-each (lambda (row)
              (displayln (map (lambda (cell) (if cell cell "_")) row)))
            board)
  (newline))

;; Jugar un turno
(define (play-turn board player)
  (if (equal? player 'O)
      (make-move board (best-move board 'O) 'O)
      (let ([row (read)])
        (let ([col (read)])
          (if (is-empty? (list-ref (list-ref board row) col))
              (make-move board (list row col) 'X)
              (begin
                (displayln "Esa celda ya está ocupada, intenta de nuevo.")
                (play-turn board player)))))))

;; Verificar si hay un ganador
(define (check-winner board player)
  (or (ormap (lambda (row) (check-row? board player row)) (range 3))
      (ormap (lambda (col) (check-column? board player col)) (range 3))
      (check-diagonals? board player)))

;; Loop del juego
(define (game-loop board turn)
  (display-board board)
  (if (check-winner board (if (equal? turn 'O) 'X 'O))
      (displayln (format "¡El jugador ~a ha ganado!" (if (equal? turn 'O) 'X 'O)))
      (if (null? (empty-cells board))
          (displayln "Es un empate.")
          (game-loop (play-turn board turn) (if (equal? turn 'O) 'X 'O)))))



;Iniciar el juego
(define (start-game)
  (display "Ingresa el tamaño de fila ")
  (define fila (read))
  (display "Ingresa el tamaño de columna ")
  (define columna (read))
  (if (and (>= fila 3) (<= fila 10) (>= columna 3) (<= columna 10))
      (game-loop (empty-board fila columna) 'X)
      (begin
        (displayln "El tamaño debe ser mayor que (0) o menor a (10).")
        (start-game))))

;; Iniciar el juego
#|
 (define (start-game)
  (displayln "¡Bienvenido a Tic-Tac-Toe!")
  (displayln "Ingresa tus movimientos como dos números separados por un espacio, por ejemplo: 0 1")
  (game-loop empty-board 'X))
|#


;; Comenzar el juego
(start-game)
