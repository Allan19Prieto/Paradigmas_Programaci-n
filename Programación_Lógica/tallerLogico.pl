
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

inversa(L1, L2) :-inversa(L1, L2).

inversa_aux(L,R):-inversa_aux(L,[],R).
inversa_aux([],Respuesta,Respuesta).
inversa_aux([C|L1],Respuesta,R):-inversa_aux(L1,[C|Respuesta],R).

% 2.6 **************************

longitud([],0).
longitud([_|R],N):-longitud(R,N1), N is N1 + 1.  

% 2.7 *************************

acontecimiento(1960, 'El Programa Apolo').
acontecimiento(1950, 'La Guerra de Corea').
acontecimiento(1986, 'El accidente de Chernóbil').

fechaevento:-
    write('Digite la fecha '),nl,
    read(Fecha),
    acontecimiento(Fecha,R),
    write('En el '),write(Fecha),write(' sucedio '),write(R), nl.

fechaevento:-
    write('No hay un acontecimiento para la fecha').
    
    
    
