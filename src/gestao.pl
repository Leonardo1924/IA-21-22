:-include('baseDeConhecimento.pl').
:-include('predicadosAuxiliares.pl').

:-style_check(-singleton).
:-style_check(-discontiguous).

% runtime defined
:-dynamic(encomendaGerida/9).


gerirEncomendas([],[],[],[],[],[],[],[],[]).
gerirEncomendas([Id|Ids], [Peso|Pesos], [Vol|Vols], [Prazo|Prazos], [Cliente|Clientes], 
                [Data|Datas], [Veiculo|Veiculos], [Estaf|Estafs], [Preco|Precos]):- 
    assert(encomendaGerida(Id, Peso, Vol, Prazo, Cliente, Data, Veiculo, Estaf, Preco)),
    gerirEncomendas(Ids, Pesos, Vols, Prazos, Clientes, Datas, Veiculos, Estafs,Precos).

classificar_entrega(Id, Nota) :-
    Nota >= 0,
    Nota =< 5, 
    retract(entrega(1, Id, _)),
    assert(entrega(1, Id, Nota)).


gerir:-
    entregas_popular,
    auxiliarId(Ids),
    auxiliarPeso(Pesos),
    auxiliarVol(Vols),
    auxiliarPrazo(Prazos),
    auxiliarCliente(Clientes),
    auxiliarData(Datas),
    listaVeiculos(Pesos, Veiculos),
    listaEstafetas(Ids,Estafs),
    listaPrecos(Veiculos, Prazos, Precos),
    gerirEncomendas(Ids, Pesos, Vols, Prazos, Clientes, Datas, Veiculos, Estafs, Precos).
