
progenitor(clara,jose). 
progenitor(tomas, jose). 
progenitor(tomas,isabel).
 progenitor(jose, ana). 
 progenitor(jose, patricia). 
 progenitor(patricia,jaime).

% Definicion de abuelo 
abuelo(X,Y):- progenitor(X,Z),progenitor(Z,Y).
%definicion de Tio
tio(X,Y):- progenitor(Z,Y),progenitor(V,Z),progenitor(V,X).

% Ejemplo usando recursividad

predecesor(X,Y):-progenitor(X,Y).
predecesor(X,Y):-progenitor(X,Z),predecesor(Z,Y).

