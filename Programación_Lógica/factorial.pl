
factorial(0,1).
factorial(N,R):- N>0 , Res is N - 1, factorial(Res,F), R is N*F.
