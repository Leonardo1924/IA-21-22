:-consult('baseDeConhecimento.pl').

:-dynamic (encomendaGerida/7).


encontraEstafetaLivre(IdEstafeta) :-
    estafeta(IdEstafeta, _, _, 'base').

decideVeiculo('Bicicleta', Peso) :-
     Peso<6.
decideVeiculo('Mota', Peso) :-
     Peso<21, Peso>=6.
decideVeiculo('Carro', Peso) :-
     Peso>=21, Peso<101.

auxiliarId(ListaIds) :- findall(Id, encomenda(Id, _, _, _, _), ListaIds).
auxiliarPeso(ListaPesos) :- findall(Peso, encomenda(_, Peso, _, _, _), ListaPesos).
auxiliarVol(ListaVol) :- findall(Vol, encomenda(_, _, Vol, _, _), ListaVol).
auxiliarPrazo(ListaPrazo) :- findall(Prazo, encomenda(_, _, _, Prazo, _), ListaPrazo).
auxiliarCliente(ListaClientes) :- findall(Cliente, encomenda(_, _, _, _, Cliente),ListaClientes).

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
    
gerirEncomenda([],[],[],[],[],[],[]).
gerirEncomenda([Id|Ids], [Peso|Pesos], [Vol|Vols], [Prazo|Prazos], [Cliente|Clientes], [Veiculo|Veiculos], [Estaf|Estafs]) :-
    assert(encomendaGerida(Id, Peso, Vol, Prazo, Cliente, Veiculo, Estaf)),
    gerirEncomenda(Ids, Pesos, Vols, Prazos, Clientes, Veiculos, Estafs).