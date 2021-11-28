:-include('baseDeConhecimento.pl').

:-style_check(-singleton).
:-style_check(-discontiguous).

% runtime defined
:-dynamic(encomendaGerida/9).

% a definir
% entrega(IdEnc, Nota).
:-dynamic(entrega/2).

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
    
auxiliarId(ListaIds) :- findall(Id, encomenda(Id, _, _, _, _, _), ListaIds).
auxiliarPeso(ListaPesos) :- findall(Peso, encomenda(_, Peso, _, _, _, _), ListaPesos).
auxiliarVol(ListaVol) :- findall(Vol, encomenda(_, _, Vol, _, _, _), ListaVol).
auxiliarPrazo(ListaPrazo) :- findall(Prazo, encomenda(_, _, _, Prazo, _, _), ListaPrazo).
auxiliarCliente(ListaClientes) :- findall(Cliente, encomenda(_, _, _, _, Cliente, _),ListaClientes).
auxiliarData(ListaDatas) :- findall(Data,encomenda(_,_,_,_,_,Data),ListaDatas).

listaVeiculos([],[]).
listaVeiculos([Peso|Pesos],[Veiculo|Result]):- 
    decideVeiculo(Veiculo,Peso), 
    listaVeiculos(Pesos,Result).

listaEstafetas([]).
listaEstafetas([IdEstafeta|Result]):- 
    encontraEstafetaLivre(IdEstafeta), 
    retract(estafeta(IdEstafeta, _, _, 'base')),
    assert(estafeta(IdEstafeta, _, _, 'naobase')),
    listaEstafetas(Result).
listaEstafetas(['n/a'|Result]) :-
    \+ encontraEstafetaLivre(IdEstafeta),
    listaEstafetas(Result).
    
listaPrecos([],[],[]).
listaPrecos([Veiculo|Veiculos],[Prazo|Prazos],[Preco|Precos]):- 
    calculaPreco(Veiculo,Prazo,Preco), 
    listaPrecos(Veiculos,Prazos,Precos).

gerirEncomendas([],[],[],[],[],[],[],[],[]).
gerirEncomendas([Id|Ids], [Peso|Pesos], [Vol|Vols], [Prazo|Prazos], [Cliente|Clientes], 
                [Data|Datas], [Veiculo|Veiculos], [Estaf|Estafs], [Preco|Precos]):-
    \+ Estaf == 'n/a', 
    assert(encomendaGerida(Id, Peso, Vol, Prazo, Cliente, Data, Veiculo, Estaf, Preco)),
    gerirEncomendas(Ids, Pesos, Vols, Prazos, Clientes, Datas, Veiculos, Estafs, Precos).
gerirEncomendas([_|Ids], [_|Pesos], [_|Vols], [_|Prazos], [_|Clientes], 
                [_|Datas], [_|Veiculos], ['n/a'|Estafs], [_|Precos]) :-
    gerirEncomendas(Ids, Pesos, Vols, Prazos, Clientes, Datas, Veiculos, Estafs, Precos).

gerir :-
    auxiliarId(Ids),
    auxiliarPeso(Pesos),
    auxiliarVol(Vols),
    auxiliarPrazo(Prazos),
    auxiliarCliente(Clientes),
    auxiliarData(Datas),
    listaVeiculos(Pesos, Veiculos),
    listaEstafetas(Estafs),
    listaPrecos(Veiculos, Prazos, Precos),
    gerirEncomendas(Ids, Pesos, Vols, Prazos, Clientes, Datas, Veiculos, Estafs, Precos).