/*
%Predicados Auxiliares
:-consult('baseDeConhecimento.pl').

:-dynamic (encomendaGerida/7).
:-style_check(-singleton).


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
    Prazo > 48, Preco is 0.50;
 
calculaPreco('Mota', Prazo, Preco) :- 
    Prazo < 24, Preco is 1,7 * 2;
    Prazo < 48, Preco is 1,7 *  1;
    Prazo > 48, Preco is 1,7 * 0.50;    


calculaPreco('Carro', Prazo, Preco) :- 
    Prazo < 24, Preco is 3 * 2;
    Prazo < 48, Preco is 3 * 1;
    Prazo > 48, Preco is 3 * 0.50;

auxiliarId(ListaIds) :- findall(Id, encomenda(Id, _, _, _, _,_), ListaIds).
auxiliarPeso(ListaPesos) :- findall(Peso, encomenda(_, Peso, _, _, _,_), ListaPesos).
auxiliarVol(ListaVol) :- findall(Vol, encomenda(_, _, Vol, _, _,_), ListaVol).
auxiliarPrazo(ListaPrazo) :- findall(Prazo, encomenda(_, _, _, Prazo, _,_), ListaPrazo).
auxiliarCliente(ListaClientes) :- findall(Cliente, encomenda(_, _, _, _, Cliente,_),ListaClientes).
auxiliarDias(ListaDias) :- findall(Dia,encomenda(_,_,_,_,_,Dia),ListaDias).

listaVeiculos([],[]).
listaVeiculos([H|Tail],[Veiculo|Result]):- 
    decideVeiculo(Veiculo,H), 
    listaVeiculos(Tail,Result).

listaEstafetas([],[]).
listaEstafetas([H|Tail],[IdEstafeta|Result]):- 
    encontraEstafetaLivre(IdEstafeta), 
    retract(estafeta(IdEstafeta,A,B,_)),
    assert(estafeta(IdEstafeta,A,B,'naobase')),
    listaEstafetas(Tail,Result).
listaEstafetas([H|Tail],[0|Result]) :-
    \+ encontraEstafetaLivre(IdEstafeta),
    listaEstafetas(Tail,Result).

listaPrecos([],[],[]).
listaPrecos([Veiculo|Veiculos],[Prazo|Prazos],[Preco|Precos]):- 
    calculaPreco(Veiculo,Prazo,Preco), 
    listaPrecos(Veiculos,Prazos,Precos).


    
gerirEncomenda([],[],[],[],[],[],[],[]).
gerirEncomenda([Id|Ids], [Peso|Pesos], [Vol|Vols], [Prazo|Prazos], [Cliente|Clientes], [Veiculo|Veiculos], [Estaf|Estafs], [Dia|Dias]. [Preco|Precos]) :-
    assert(encomendaGerida(Id, Peso, Vol, Prazo, Cliente, Veiculo, Estaf,Dia,Preco)),
    gerirEncomenda(Ids, Pesos, Vols, Prazos, Clientes, Veiculos, Estafs,Dias,Precos).


encontraFreguesia([IdCliente|IdsCliente],[Result|Results]):- 
    findall(Freguesia ,cliente(IdCliente,_,_,_,_,Freguesia,_),Result).
    encontraFreguesia(IdsCliente,Results).
*/


