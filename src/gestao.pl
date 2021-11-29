:-include('baseDeConhecimento.pl').
:-include('predicadosAuxiliares.pl').

:-style_check(-singleton).
:-style_check(-discontiguous).

% runtime defined
:-dynamic(encomendaGerida/9).


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
    assert_entregas,
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

classificar_entrega(Id, Nota) :-
    Nota >= 0,
    Nota =< 5, 
    retract(entrega(1, Id, _)),
    assert(entrega(1, Id, Nota)).