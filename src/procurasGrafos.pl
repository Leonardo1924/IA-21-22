:-style_check(-singleton).
:-style_check(-discontiguous).

:-include('baseDeConhecimento.pl').


adjacente(Nodo,ProxNodo,C) :- aresta(Nodo,ProxNodo,C).
adjacente(Nodo,ProxNodo,C) :- aresta(ProxNodo,Nodo,C).


dfs(Orig,Dest,Cam,Custo):- dfs2(Orig,Dest,[Orig],Cam,Custo).

dfs2(Dest,Dest,LA,Cam,0):- reverse(LA,Cam).
dfs2(Act,Dest,LA,Cam,Custo):-
    adjacente(Act,X,Custo1),
    \+ member(X,LA),
    dfs2(X,Dest,[X|LA],Cam,Custo2), %chamada recursiva
    Custo is Custo1 + Custo2.




bfs(Orig, Dest, Cam, Custo) :- bfs2(Orig, Dest,[[Orig]],Cam, Custo).

bfs2(Dest,[[Dest|T]],Cam, Custo):- reverse([Dest|T],Cam). %o caminho aparece pela ordem inversa
bfs2(Dest,[LA|Outros],Cam, Custo):-
    LA = [Act|_],
    findall([X|LA],
            (DEST\==Act,adjacente(Act,X, Custo1),
            \+ member(X,LA)),Novos),
    append(Outros,Novos,Todos),
    bfs2(Dest,Todos,Cam, Custo2),
    Custo is Custo1 + Custo2.



listaDeAdjacentes(X, Lista):- findall(Y, adjacente(X, Y, _), Lista).

menorCustoGreedy([H|ListaAdj], X):-
    estima(H, CustoAprox),
    menorCustoAux(ListaAdj, CustoAprox, H, X).

menorCustoAux([], CustoAprox, X, X).
menorCustoAux([H|T], CustoAprox, NodeCloser, X):-
    estima(H, Y),
    Y>= CustoAprox,
    menorCustoAux(T, CustoAprox, NodeCloser, X).
menorCustoAux([H|T], CustoAprox, NodeCloser, X):-
    estima(H, Y),
    Y < CustoAprox,
    menorCustoAux(T, Y, H, X).

gulosa(Inicio, Path, Cost):- gulosaAux(Inicio, [], 0, Path, Cost).

gulosaAux(maximinos, Visited, Cost, Path, Cost):- reverse([maximinos|Visited], Path).
gulosaAux(Node, Visited, Cost, Path, Total):-
    listaDeAdjacentes(Node, ListAdj),
	menorCustoGreedy(ListAdj, NextNode),
	\+ member(NextNode, Visited),
	adjacente(Node, NextNode, Value),
	NewCost is Cost + Value,
	gulosaAux(NextNode, [Node|Visited], NewCost, Path, Total).



resolve_aestrela(Inicio,Final,CaminhoDistancia/CustoDist) :-
	estima(Inicio, EstimaD),
	aestrela_distancia([[Inicio]/0/EstimaD],Final ,InvCaminho/CustoDist/_),
	reverse(InvCaminho, CaminhoDistancia).

aestrela_distancia(Caminhos, Final, Caminho) :-
	obtem_melhor_distancia(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,Final.

aestrela_distancia(Caminhos, Final ,SolucaoCaminho) :-
	obtem_melhor_distancia(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_aestrela_distancia(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    aestrela_distancia(NovoCaminhos, SolucaoCaminho).	

obtem_melhor_distancia([Caminho], Caminho) :- !.
obtem_melhor_distancia([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor_distancia([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho). 
obtem_melhor_distancia([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor_distancia(Caminhos, MelhorCaminho).
	

expande_aestrela_distancia(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente_distancia(Caminho,NovoCaminho), ExpCaminhos).


seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).
