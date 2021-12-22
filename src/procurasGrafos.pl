

adjacente(Nodo,ProxNodo,C) :- aresta(Nodo,ProxNodo,C).
adjacente(Nodo,ProxNodo,C) :- aresta(ProxNodo,Nodo,C).


dfs(Orig,Dest,Cam,Custo):- dfs2(Orig,Dest,[Orig],Cam,Custo).
dfs2(Dest,Dest,LA,Cam,0):- reverse(LA,Cam).
dfs2(Act,Dest,LA,Cam,Custo):- adjacente(Act,X,Custo1),
        \+ member(X,LA), 
         dfs2(X,Dest,[X|LA],Cam,Custo2), Custo is Custo1 + Custo2. %chamada recursiva 



bfs(Orig, Dest, Cam, Custo) :- bfs2(Orig, Dest,[[Orig]],Cam, Custo).
bfs2(Dest,[[Dest|T]|],Cam, Custo):- reverse([Dest|T],Cam). %o caminho aparece pela ordem inversa
bfs2(Dest,[LA|Outros],Cam, Custo):- LA = [Act|],
    findall([X|LA],
    (Dest==Act,adjacente(Act,X, Custo1),
    \+member(X,LA)),Novos),
        append(Outros,Novos,Todos),
        bfs2(Dest,Todos,Cam, Custo2), Custo is Custo1 + Custo2.