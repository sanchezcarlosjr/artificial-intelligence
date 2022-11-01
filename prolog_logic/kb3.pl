% state(id, name).
state('Mono en la puerta').
state('Mono a lado de la caja').
state('Caja en la ventana').
state('Parado sobre la caja, directamente bajo la banana').
state('Con banana').
start(state('Mono en la puerta')).
goal(state('Con banana')).

% action(current state, action, new state, cost?).
action(state('Mono en la puerta'),'Caminar sobre el piso', state('Mono a lado de la caja')).
action(state('Mono a lado de la caja'), 'Empujar la caja', state('Caja en la ventana')).
action(state('Caja en la ventana'),'Trepar la caja', state('Parado sobre la caja, directamente bajo la banana')).
action(state('Parado sobre la caja, directamente bajo la banana'),'Coger la banana', state('Con banana')).

% Agent acts using available actions until it lies its goal.
act(State) :- goal(State).
act(State) :- action(State, Action, NewState), act(NewState), write(Action).

% Query this for your agent acts rationally.
% ?- start(State), act(State).
