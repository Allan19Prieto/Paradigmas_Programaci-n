% HECHOS
padrede(martin,luis).
padrede(luis,jose).
padrede(luis,pedro).
espadre(martin).
espadre(luis).

% REGLAS
hijode(B,A):-padrede(A,B).

% REGLAS_AND
abuelo(A,B):-padrede(A,Z),padrede(Z,B).
hermanode(A,B):-espadre(P),padrede(P,A),padrede(P,B).

% REGLAS_OR
familiarde(A,B):-padrede(A,B);padrede(B,A);hijode(B,A);hijode(A,B);abuelo(A,B);abuelo(B,A);hermano(A,B).