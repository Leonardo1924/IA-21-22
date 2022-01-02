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

bfs2(Dest,[[Dest|T]|],Cam, Custo):- reverse([Dest|T],Cam). %o caminho aparece pela ordem inversa
bfs2(Dest,[LA|Outros],Cam, Custo):-
    LA = [Act|],
    findall([X|LA],
            (Dest==Act,adjacente(Act,X, Custo1),
            \+ member(X,LA)),Novos),
    append(Outros,Novos,Todos),
    bfs2(Dest,Todos,Cam, Custo2),
    Custo is Custo1 + Custo2.



listaDeAdjacentes(X, Lista):- findall(Y, adjacente(X, Y, _), Lista).

menorCustoGreedy([H|ListaAdj], X):-
    node(H, CustoAprox),
    menorCustoAux(ListaAdj, CustoAprox, H, X).

menorCustoAux([], CustoAprox, X, X).
menorCustoAux([H|T], CustoAprox, NodeCloser, X):-
    node(H, Y),
    Y>= CustoAprox,
    menorCustoAux(T, CustoAprox, NodeCloser, X).
menorCustoAux([H|T], CustoAprox, NodeCloser, X):-
    node(H, Y),
    Y < CustoAprox,
    menorCustoAux(T, Y, H, X).

gulosa(Inicio, Path, Cost):- gulosaAux(Inicio, [], 0, Path, Cost).

gulosaAux('Maximinos', Visited, Cost, Path, Cost):- reverse(['Maximinos'|Visited], Path).
gulosaAux(Node, Visited, Cost, Path, Total):-
    listaDeAdjacentes(Node, ListAdj),
	menorCustoGreedy(ListAdj, NextNode),
	\+ member(NextNode, Visited),
	adjacente(Node, NextNode, Value),
	NewCost is Cost + Value,
	gulosaAux(NextNode, [Node|Visited], NewCost, Path, Total).