% is X a list ?
list([]).
list([_|_]).

% is L the concatenation of List1 and List2?
% List = List1 concat List2
concat([], List, List). 
concat([X|L1], L2, [X|L3]) :- concat(L1,L2,L3).
% ?- concat([a,b], [c,d], [a,b,c,d]).
% concat([b], [c,d], [b,c,d]) by rule 2
% concat([], [c,d], [c,d]) by rule 2
% true by rule 1

% is X the last element in list?
last(X, List) :- concat(_, [X], List).

% is S a sublist of L?
% is there a possible decomposition L called L2 such that L2 would be equals S?
sublist(S,L) :- concat(_, L2, L), % L2 is a sublist of L since L is decomposed in L2 and a list no empty.
                concat(S, _, L2). % S is a sublist of L2 since L2 is decomposed in S and a list no empty.
% ?- sublist([3,4], [1,2,3,4,5]).
% concat(_, L2, [1,2,3,4,5]). L2=[1,2,3,4,5], L2=[2,3,4,5], L2=[3,4,5], L2=[4,5], L2=[5], L2=[].
% concat(S, _, L2). What L2 decomposition is equals to S? [3,4]


% prolog has list library.
% ?- use_module(libray(lists)).
member(Head, [Head|_]).
member(X, [_|Tail]) :- member(X, Tail).


% is A a subset of B?
% A is subset of B, if for all x in A, x in A then x in B.
subset([X|Xs],B) :- member(X, B), subset(Xs, B).
subset([],B) :- list(B).

length2([], 0).
length2([_|Xs],succesor(N)) :- length(Xs, N).

length3([], 0).
length3([_|Xs], L) :- length3(Xs, N), L is N+1.


% max(X,Y,Max) :- Max is X if X>Y otherwise Y
max(X,Y,X) :- X>=Y.
max(X,Y,Y) :- Y>X.

maxList([Max],Max).
maxList([A|Tail], Max) :- maxList(Tail, B), max(A,B,M), Max is M.

sum([X], X).
sum([A|Tail], Sum) :- sum(Tail, B), Sum is A+B.

mean(List, Mean) :- length3(List, Length), sum(List, Sum), Mean is Sum/Length.

% factorial(Number, Factorial).
% N*factorial(N-1)
factorial(0, 1).
factorial(N, Factorial) :- N>0,T is N-1,factorial(T, F), Factorial is N*F.

% numbers in Spanish
sound(0,cero).
sound(1,uno).
sound(2,dos).
sound(3,tres).
sound(4,cuatro).
sound(5,cinco).
sound(6,seis).
sound(7,siete).
sound(8,ocho).
sound(9,nueve).

insert(X, List, [X|List]).

translate([], []).
translate([X|Xs],[Y|Ys]) :- sound(X,Y), translate(Xs, Ys).
