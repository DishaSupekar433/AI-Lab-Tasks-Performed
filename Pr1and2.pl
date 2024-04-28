valuable(gold).

find_max(X, Y, X) :- X >= Y, !.
find_max(X, Y, Y) :- X < Y.
find_min(X, Y, X) :- X =< Y, !.
find_min(X, Y, Y) :- X > Y.

is_ele(X) :- X>18, !.

fact(0, 1).
fact(X, F) :- X>0, N is X-1, fact(N, F1), F is X * F1.
