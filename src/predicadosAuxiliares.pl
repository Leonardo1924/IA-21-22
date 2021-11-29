:-include('baseDeConhecimento.pl').

:-style_check(-singleton).
:-style_check(-discontiguous).

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

auxiliarId(ListaIds) :- 
    findall(Id, (encomenda(Id, _, _, _, _, _), entrega(0, Id, _)), ListaIds).

auxiliarPeso(ListaPesos) :- 
    findall(Peso, (encomenda(Id, Peso, _, _, _, _), entrega(0, Id, _)), ListaPesos).

auxiliarVol(ListaVol) :-
    findall(Vol, (encomenda(Id, _, Vol, _, _, _), entrega(0, Id, _)), ListaVol).

auxiliarPrazo(ListaPrazo) :- 
    findall(Prazo, (encomenda(Id, _, _, Prazo, _, _), entrega(0, Id, _)), ListaPrazo).

auxiliarCliente(ListaClientes) :- 
    findall(Cliente, (encomenda(Id, _, _, _, Cliente, _), entrega(0, Id, _)), ListaClientes).

auxiliarData(ListaDatas) :- 
    findall(Data, (encomenda(Id, _, _, _, _, Data), entrega(0, Id, _)),ListaDatas).

update_entrega(IdEnc) :-
    retract(entrega(0, IdEnc, N)),
    assert(entrega(1, IdEnc, N)).

update_estafeta(IdEstaf) :-
    retract(estafeta(IdEstaf, Nome, C, 'naobase')),
    assert(estafeta(IdEstaf, Nome, C, 'base')).

assert_entregas :-
    findall(Id, (encomenda(Id, _, _, _, _, _), assert(entrega(0, Id, 0))), L).