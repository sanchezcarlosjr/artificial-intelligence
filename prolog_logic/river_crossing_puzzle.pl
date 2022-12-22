mover([n,n,n,n],llevar_lobo,[s,s,n,n]).
mover([X,X,Cabra,Repollo], llevar_lobo,[Y,Y,Cabra,Repollo]) :- cambiar(X,Y).
mover([X,Lobo,X,Repollo],mover_cabra,[Y,Lobo,Y,Repollo]) :- cambiar(X,Y).
mover([X,Lobo,Cabra,X],mover_repollo,[Y,Lobo,Cabra,Y]) :- cambiar(X,Y).
mover([X,Lobo,Cabra,Repollo],mover_nada,[Y,Lobo,Cabra,Repollo]):- cambiar(X,Y).

cambiar(s,n).
cambiar(n,s).     


al_menos_uno_igual(X,X,_).
al_menos_uno_igual(X,_,X).

estado_seguro([Farmer,Lobo,Cabra,Repollo]) :- al_menos_uno_igual(Farmer,Cabra,Lobo), al_menos_uno_igual(Farmer,Cabra,Repollo).


solucion([s,s,s,s],[]).
solucion(Estado,[PrimerMovimiento|MovimientosRestantes]) :-
       mover(Estado,PrimerMovimiento,EstadoSiguiente),
       estado_seguro(EstadoSiguiente),
       solucion(EstadoSiguiente,MovimientosRestantes).
