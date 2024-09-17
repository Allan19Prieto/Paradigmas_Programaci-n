% Función Miembro %
miembro(X,[X|_]).
miembro(X,[_|R]):-miembro(X,R).

% Función inversa %
inversa(L1,[L]):-inversa(L1,[],L).
inversa([],L,L).
inversa([X|L1],L2,L3):-inversa(L1,[X|L2],L3).

%  Cree las clausulas para longitud.  %
%   Longitud([a,b,c,d,e],5).
%   True




