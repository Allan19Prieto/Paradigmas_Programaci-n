% Caso base: la inversa de una lista vacía es una lista vacía.
inversa([], []).

% Caso recursivo: la inversa de una lista [H|T] es la inversa de T concatenada con [H].
inversa([H|T], R) :-
    inversa(T, RT),
    append(RT, [H], R).

