% Ejemplo de miembro de una lista

miembro(X,[X|_]).
miembro(X,[_|R]):-miembro(X,R).

% Concatenar lista
concatenar([],L, L).
concatenar([X|L1],L2,[X|L3]):-concatenar(L1,L2,L3).

%Boorrar elemento de una lista
borrar(_,[],[]).
borrar(X,[X|L],L).
borrar(X,[Y|L],[Y|L1]):-borrar(X,L,L1).

% Añadir elemento a una lista
anadir(X,[],[X]).
anadir(X,L,[X|L]).