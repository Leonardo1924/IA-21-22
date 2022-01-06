
:-style_check(-singleton).
:-style_check(-discontiguous).
        
:-include('procurasGrafos.pl').
  
encontraEstafetaLivre(IdEstafeta) :-
    estafeta(IdEstafeta, _, _, 'base').

decideVeiculo('Bicicleta', Peso) :-
     Peso<6.
decideVeiculo('Mota', Peso) :-
     Peso<21, Peso>=6.
decideVeiculo('Carro', Peso) :-
     Peso>=21, Peso<101.

calculaPreco('Bicicleta', Prazo, Preco) :- 
    Prazo < 24, Preco is 2;
    Prazo < 48, Preco is 1;
    Prazo > 48, Preco is 0.50.
calculaPreco('Mota', Prazo, Preco) :- 
    Prazo < 24, Preco is 1.7 * 2;
    Prazo < 48, Preco is 1.7 *  1;
    Prazo > 48, Preco is 1.7 * 0.50.    
calculaPreco('Carro', Prazo, Preco) :- 
    Prazo < 24, Preco is 3 * 2;
    Prazo < 48, Preco is 3 * 1;
    Prazo > 48, Preco is 3 * 0.50.

listaVeiculos([],[]).
listaVeiculos([Peso|Pesos],[Veiculo|Result]):- 
    decideVeiculo(Veiculo,Peso), 
    listaVeiculos(Pesos,Result).


listaEstafetas([],[]).
listaEstafetas([H|Tail],[IdEstafeta|Result]):- 
    encontraEstafetaLivre(IdEstafeta), 
    retract(estafeta(IdEstafeta,A,B,_)),
    assert(estafeta(IdEstafeta,A,B,'naobase')),
    listaEstafetas(Tail,Result).
listaEstafetas([H|Tail],["n/a"|Result]) :-
    \+ encontraEstafetaLivre(IdEstafeta),
    listaEstafetas(Tail,Result).
    
listaPrecos([],[],[]).
listaPrecos([Veiculo|Veiculos],[Prazo|Prazos],[Preco|Precos]):- 
    calculaPreco(Veiculo,Prazo,Preco), 
    listaPrecos(Veiculos,Prazos,Precos).

auxiliarId(ListaIds) :-
	 findall(Id,encomenda(Id,_,_,_,_,_),ListaIds).

auxiliarPeso(ListaPesos) :-
	 findall(Peso,encomenda(_,Peso,_,_,_,_),ListaPesos).

auxiliarVol(ListaVol) :- 
	findall(Vol,encomenda(_,_,Vol,_,_,_),ListaVol).

auxiliarPrazo(ListaPrazo) :-
	 findall(Prazo,encomenda(_,_,_,Prazo,_,_),ListaPrazo).

auxiliarCliente(ListaClientes) :- 
	findall(Cliente,encomenda(_,_,_,_,Cliente,_),ListaClientes).

auxiliarData(ListaDatas) :- 
	findall(Data, encomenda(_, _, _, _, _, Data),ListaDatas).

update_entrega([], []).
update_entrega([Id|Ids], [S|Stars]) :-
    retract(entrega(0, Id, _)),
    assert(entrega(1, Id, S)),
    update_entrega(Ids, Stars).

update_estafeta(IdEstaf) :-
    retract(estafeta(IdEstaf, Nome, C, 'naobase')),
    assert(estafeta(IdEstaf, Nome, C, 'base')).


entregas_popular :-
    findall(Id,encomenda(Id, _, _, _, _, _), Lista),
    sort(Lista,ListaS),
    assert_auxiliar(ListaS).

assert_auxiliar([]).
assert_auxiliar([H|T]) :-  
	assert(entrega(0,H,0)),
	assert_auxiliar(T).

percorreEncomendas(Ids,Pesos,Prazos,Velocidades,Freguesias,Distancias) :-
    findall(Id,encomenda(Id, _, _, _, _, _, _, _, _,), Ids),
    findall(Peso, encomenda(_, Peso, _, _, _, _, _, _, _,), Pesos),
    findall(Prazo, encomenda(_, _, _, Prazo, _, _, _, _,), Prazos),
    findall(IdCliente ( _, _, _, _, _, IdCliente, IdClientes),
    procuraFreguesia(IdClientes,Freguesias),
    calculaVelocidade(Pesos, Velocidades),
    calculaDistancias(Flag,Freguesias,Custos).

calculaStar([], [], [], []).
calculaStar([Id|Ids], [V|Velocidades], [D|Distancias], [S|Stars]) :-
    encomenda(Id, _, _, Prazo, _, _, _, _,),
    V > 0,
    Tempo is D / V,
    Tempo < Prazo + 2 -> S is 5;
    Tempo >= Prazo + 2, Tempo < Prazo + 4 -> S is 4;
    Tempo >= Prazo + 4, Tempo < Prazo + 25 -> S is 3;
    Tempo >= Prazo + 25, Tempo < Prazo + 49 -> S is 2;
    Tempo >= Prazo + 49 -> S is 1,
    calculaStar(Ids, Velocidades, Distancias, Stars).
    
calculaVelocidade([], []).
calculaVelocidade([P|Pesos], [Vel|Velocidades]) :-
    P < 6 -> Vel is 10 - 0,7*P;
    P < 21, P>=6 -> Vel is 35-0,5*P;
    P >= 21, P <101 -> Vel is 25-0,1*P,
    calculaVelocidade(Pesos, Velocidades).

procuraFreguesia([], []).
procuraFreguesia([IdC|IdClientes], [F|Freguesias]) :-
    findall(F, findall(Id,_,_,_,_,F,_),Freg),
    procuraFreguesia(IdClientes, Freguesias).

calculaDistancias(_, [], []).
calculaDistancias('1',[F|Freguesias],[Custo|Custos]) :-
    dfs('Maximinos',F,Cam,Custo),
    calculaDistancias('1',Freguesias, Custos).
calculaDistancias('2',[F|Freguesias],[Custo|Custos]) :-
     bfs('Maximinos',F,Cam,Custo),
     calculaDistancias('2',Freguesias, Custos).
calculaDistancias('3',[F|Freguesias],[Custo|Custos]) :-
    dfs('Maximinos',F,Cam,Custo),
    calculaDistancias('1',Freguesias, Custos).
    

