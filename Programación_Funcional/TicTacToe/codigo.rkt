#lang scheme


;; Representación del tablero
(define empty-board '((#f #f #f) (#f #f #f) (#f #f #f)))

;; Función para verificar si una celda está vacía
(define (is-empty? cell)
  (equal? cell #f))

;; Obtener lista de celdas vacías
(define (empty-cells board)
  (for*/list ([i (in-range 3)]
              [j (in-range 3)]
              #:when (is-empty? (list-ref (list-ref board i) j)))
    (list i j)))

;; Función para actualizar una lista en una posición específica
(define (update-list lst index new-value)
  (append (take lst index) (list new-value) (drop lst (+ index 1))))

;; Actualizar el tablero con una nueva jugada
(define (make-move board move player)
  (let* ([row (list-ref board (first move))]
         [new-row (update-list row (second move) player)])
    (update-list board (first move) new-row)))

;; Verificar si una fila es ganadora
(define (check-row? board player row)
  (and (equal? (list-ref (list-ref board row) 0) player)
       (equal? (list-ref (list-ref board row) 1) player)
       (equal? (list-ref (list-ref board row) 2) player)))

;; Verificar si una columna es ganadora
(define (check-column? board player column)
  (and (equal? (list-ref (list-ref board 0) column) player)
       (equal? (list-ref (list-ref board 1) column) player)
       (equal? (list-ref (list-ref board 2) column) player)))

;; Verificar si alguna diagonal es ganadora
(define (check-diagonals? board player)
  (or (and (equal? (list-ref (list-ref board 0) 0) player)
           (equal? (list-ref (list-ref board 1) 1) player)
           (equal? (list-ref (list-ref board 2) 2) player))
      (and (equal? (list-ref (list-ref board 0) 2) player)
           (equal? (list-ref (list-ref board 1) 1) player)
           (equal? (list-ref (list-ref board 2) 0) player))))

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

;; Iniciar el juego
(define (start-game)
  (displayln "¡Bienvenido a Tic-Tac-Toe!")
  (displayln "Ingresa tus movimientos como dos números separados por un espacio, por ejemplo: 0 1")
  (game-loop empty-board 'X))

;; Comenzar el juego
(start-game)
