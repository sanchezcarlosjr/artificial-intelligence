man(tom).
man(bob).
man(jim).
woman(liz).
woman(pat).
woman(pam).
woman(ann).

mother(X,Y) :- parent(X,Y), woman(X).

sister(X,Y) :- parent(Parent,X), parent(Parent, Y), woman(X).

grandfather(Person1, Person2) :- parent(Person1, Child), parent(Child, Person2), man(Person1).
