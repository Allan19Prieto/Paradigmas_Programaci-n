% Porcesamineto de lenuaje naturar
% Necesitamos -> 1 Análisis léxico 2 Análisis Sintáctico 3 Análisis semántico

% Gramatica libre de contexto

% Gramática básica

oracion --> sujeto, verbo, objeto.

sujeto --> [el, perro]; [la, gata]; [el, hombre]; [la, mujer].
verbo --> [come]; [mira]; [persigue].
objeto --> [la, comida]; [el, gato]; [la, pelota].

% Predicado para tokenizar la oración y verificarla con la gramática
procesar_oracion(Oracion) :-
    atomic_list_concat(ListaPalabras, ' ', Oracion),  % Convertimos la cadena en una lista de palabras
    (   oracion(ListaPalabras, [])                    % Si la oración es válida
    ->  write('Oración válida.'), nl
    ;   write('Oración inválida.'), nl ).

% Bucle principal de interacción
chat :-
    write('Escribe una oración o "salir" para terminar:'), nl,
    read_line_to_string(user_input, Oracion),          % Leer entrada del usuario
    (   Oracion == "salir"                             % Condición para terminar el chat
    ->  write('Adiós!'), nl
    ;   procesar_oracion(Oracion),                     % Procesar la oración ingresada
        chat                                           % Llamar de nuevo al chat para seguir interactuando
    ).

