
% 2.1 **********************
padre(clara,jose).
padre(tomas,jose).
padre(tomas,isabel).
padre(jose,ana).
padre(jose,patricia).
padre(patricia,jaime).

% 2.1.1 Quine son los abuelos de jaime
abuelo(X,Y):-padre(X,Z),padre(Z,Y).

% 2.1.2 Quienes son los Bisabuelos de Jaime
bisabuelo(X,Y):-padre(X,A),padre(A,B),padre(B,Y).

% 2.2 ***********************
 
% El oro es valioso.
valioso(oro).
% Ana es mujer
persona(ana,mujer).
% juan tiene oro.
tiene(juan,oro).
% juan es padre de maría.
espadre(juan,maria).
% juan presta libro a maria
presta(libro,juan,maria).
% juan presta lapiz a pedro.
presta(lapiz,juan,pedro).
% pedro presta el borrador a juan
presta(borrador,pedro,juan).

% 2.3 **************************
varon(albert).
varon(edward).
mujer(alice).
mujer(victoria).
padres(edward,victoria,albert).
padres(alice,victoria,albert).

% Regla hermana_de(X,Y)
hermana_de(X,Y):-padres(X,A,B),padres(Y,A,B).

% 2.4 ***************************
miembro(X,[X|_]).
miembro(X,[_|R]):-miembro(X,R).

% 2.5 **************************


