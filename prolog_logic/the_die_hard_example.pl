/*
State Machine example.

On the fountain, there should be 2 jugs, do you see them? A 5-gallon and a 3-gallon. 
Fill one of the jugs with exactly 4 gallons of water and place it on the scale and the timer will stop. 
You must be precise; one ounce more or less will result in detonation. If you’re still alive in 5 minutes, we’ll speak.

Die Hard 3: With a Vengeance. 
*/

/*  Abstraction.
    Let be a tuple (5-gallon, 3 gallon).
    Our state machine starts (0,0) and it has to finish in (4, b).
    (0,0) -> ... -> (4,b).
*/

start(state(0,0)).
final(state(4,_)).

/* What precise movements do we have to do? */

/* Fill the jugs from fountain. */
arc(state(A,B), state(A,3)) :- A >= 0, 5 >= A, B >= 0, 3 >= B.
arc(state(A,B), state(5,B)) :- A >= 0, 5 >= A, B >= 0, 3 >= B.

/* Empty the jugs */ 
arc(state(A,B), state(0,B)) :- A > 0, 5 >= A, B >= 0, 3 >= B.
arc(state(A,B), state(A,0)) :- A > 0, 5 >= A, B >= 0, 3 >= B.

/* Fill the jugs from each other. */
 arc(state(A,B), state(0,Z)) :- 3 >= A+B, Z is A+B, Z > 0.
arc(state(A,B), state(Z,3)) :- A > 0, 5 >= A, B > 0, 3 >= B, A+B > 3, Z is A-(3-B).


/* No works.  */
recognize(State) :- final(State), !.
recognize(State) :- arc(State, NewState), State \= NewState.


/*
?- start(Start), arc(Start, A), arc(A, B), arc(B, C), arc(C, D), arc(D, E), arc(E,F), final(F).
Start = state(0, 0),
A = state(5, 0),
B = state(2, 3),
C = state(2, 0),
D = state(0, 2),
E = state(5, 2),
F = state(4, 3).
*/
