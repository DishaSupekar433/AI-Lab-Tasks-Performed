% Initial state: Jug1 is full (4L), Jug2 is empty (0L)
% Initial state: Jug1 is full (4L), Jug2 is empty (0L)
% Target state: Jug1 has 2L of water, regardless of Jug2
% Capacity: Jug1 = 4L, Jug2 = 3L

% Predicate to define the initial state
initial_state(4, 0).

% Predicate to define the target state
target_state(2, _).

% Predicate to define the valid actions
valid_action(fill_jug1, _, 4).
valid_action(fill_jug2, _, 3).
valid_action(empty_jug1, 0, _).
valid_action(empty_jug2, _, 0).
valid_action(pour_jug1_to_jug2, Jug1, Jug2) :-
    Total is Jug1 + Jug2,
    Total > 0,
    Total =< 3, % Total must be less than or equal to Jug2's capacity
    Jug1 > 0. % Jug1 must have some water.
valid_action(pour_jug2_to_jug1, Jug1, Jug2) :-
    Total is Jug1 + Jug2,
    Total > 0,
    Total =< 4, % Total must be less than or equal to Jug1's capacity
    Jug2 > 0. % Jug2 must have some water.

% Predicate to perform an action and get the resulting state
perform_action(fill_jug1, _, 4, 0).
perform_action(fill_jug2, _, 0, 3).
perform_action(empty_jug1, _, 0, Jug2).
perform_action(empty_jug2, Jug1, Jug1, 0).
perform_action(pour_jug1_to_jug2, Jug1, NewJug1, NewJug2) :-
    NewJug2 is min(Jug1 + Jug2, 3),
    NewJug1 is Jug1 - (NewJug2 - Jug2).
perform_action(pour_jug2_to_jug1, Jug1, NewJug1, NewJug2) :-
    NewJug1 is min(Jug1 + Jug2, 4),
    NewJug2 is Jug2 - (NewJug1 - Jug1).

% Predicate to solve the water jug problem
solve(State, State, _, []). % Base case: Target state reached
solve(State, Target, Visited, [Action|Actions]) :-
    \+ member(State, Visited), % Ensure state hasn't been visited
    valid_action(Action, Jug1, Jug2), % Check valid actions
    perform_action(Action, Jug1, NewJug1, NewJug2), % Perform action
    NewState = (NewJug1, NewJug2),
    solve(NewState, Target, [State|Visited], Actions).

% Predicate to print the solution
print_solution([]).
print_solution([(Action, Jug1, Jug2)|T]) :-
    format('Action: ~w, Jug1: ~wL, Jug2: ~wL~n', [Action, Jug1, Jug2]),
    print_solution(T).

% Predicate to solve the water jug problem and print the solution
solve_water_jug :-
    initial_state(Jug1, Jug2),
    target_state(TargetJug1, TargetJug2),
    solve((Jug1, Jug2), (TargetJug1, TargetJug2), [], Actions),
    reverse(Actions, ReversedActions), % Reverse the actions to print in correct order
    print_solution(ReversedActions).
