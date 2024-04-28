is_ele(X) :- X>18, !.
fact(0, 1).
fact(X, F) :- X>0, N is X-1, fact(N, F1), F is X * F1.
female(disha).
female(aparna).
female(saraswati).
female(suvarna).
female(tanu).
female(praful).
male(varad).
male(yogesh).
male(vinayak).
male(shailesh).
male(dattatray).
parent(aparna, disha).
parent(aparna, varad).
parent(yogesh, disha).
parent(yogesh, varad).
parent(suvarna, tanu).
parent(saraswati, suvarna).
parent(saraswati, aparna).
parent(vinayak, aparna).
parent(vinayak, suvarna).
parent(praful, yogesh).
parent(praful, shailesh).
parent(dattatray, yogesh).
parent(dattatray, shailesh).
mother(X,Y):- parent(X,Y),female(X).
father(X,Y):-parent(X,Y),male(X).
sister(X,Y):-parent(Z,X),parent(Z,Y),female(X),X\==Y.
brother(X,Y):-parent(Z,X),parent(Z,Y),male(X),X\==Y.
grandparent(X,Y):-parent(X,Z),parent(Z,Y).
grandmother(X,Z):-mother(X,Y),parent(Y,Z).
grandfather(X,Z):-father(X,Y),parent(Y,Z).
wife(X,Y):-parent(X,Z),parent(Y,Z),female(X),male(Y).
uncle(X,Z):-brother(X,Y),parent(Y,Z).
female_cousin(X, Y):-sister(P,X),parent(P,Z),(sister(Y,Q),parent(Q,Z);brother(Y,Q),parent(Q,Z)),female(X).
mother_in_law(X, Y):- wife(X, Z), parent(Y, Z), female(X).
daughter_in_law(X, Y):- wife(X, Y); sister(X, Z), brother(Z, Y), male(Y).
has_both_parents(X):- mother(M, X), father(F, X), M \== F.
haschild(X):- parent(X,_).

