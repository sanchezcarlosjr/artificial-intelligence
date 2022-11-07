
identificar:-hipotesis(Animal),write('Pienso que el Animal es: '),write(Animal),nl,undo.


hipotesis(onza)      :- onza, !.
hipotesis(tigre)     :- tigre, !.
hipotesis(jirafa)    :- jirafa, !.
hipotesis(cebra)     :- cebra, !.
hipotesis(avestruz)  :- avestruz, !.
hipotesis(pinguino)  :- pinguino, !.
hipotesis(albatros)  :- albatros, !.

 /* sin diagnostico */
hipotesis(desconocido).


onza :-     
           carnivoro, 
           verify(es_color_leonado),
           verify(tiene_manchas_oscuras).
tigre :- 
         carnivoro,
         verify(es_color_leonado), 
         verify(tiene_franjas_negras).

jirafa :- ungulado, 
          verify(es_color_leonado),
	  verify(tiene_cuello_largo),
	  verify(tiene_patas_largas).

cebra :- ungulado,
         verify(es_color_blanco),
	 verify(tiene_franjas_negras).

avestruz :- ave,
            verify(tiene_patas_largas),
	    verify(tiene_cuello_largo),
	    verify(es_blanca_y_negra).

pinguino :- ave,
            verify(no_vuela),
	    verify(nada),
	    verify(es_blanco_negro).

albatros :- ave,
            verify(vuela_muy_bien).

mamifero    :- verify(tiene_pelo), !.
mamifero    :- verify(da_leche).

ave         :- verify(tiene_plumas), !.
ave         :- verify(vuela), 
               verify(pone_huevos).

carnivoro :- mamifero,verify(come_carne), !.
carnivoro :- mamifero,verify(tiene_dientes_agudos), 
             verify(tiene_garras),
             verify(tiene_ojos_que_mira_hacia_adelante).

ungulado :- mamifero, verify(tiene_pezunas), !.
ungulado :- mamifero, verify(rumia), !.



ask(Question) :-
    write('El animal tiene la siguiente característica : '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).


verify(S) :-   
        (yes(S) -> true ;
        (no(S) -> fail ;
         ask(S))).

undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.

:- dynamic no/1.
:- dynamic yes/1.


