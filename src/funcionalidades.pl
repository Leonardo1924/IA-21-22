%Funcionalidades

:- consult('predicadosAuxiliares.pl').
:- consult('BaseDeConhecimento.pl').
:-consult('.pl').

:-style_check(-singleton).

%------------------------------------------------
% Q1 - identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico;
mais_ecologico(LIds, IdR) :-
    mais_ecologico_aux(LIds, -1, IdR).

mais_ecologico_aux([], _, null).
mais_ecologico_aux([Id], _, Id).
mais_ecologico_aux([Id|Ids], Avg, Id) :-
    findall(Veiculo, encomendaGerida(_, _, _, _, _, Veiculo, Id,_,_), ListaVeiculos),
    conta_veiculos(ListaVeiculos, Sum, Count),
    Count \= 0,
    mais_ecologico_aux(Ids, Avg_, _),
    Avg is Sum / Count,
    Avg > Avg_.
mais_ecologico_aux([Id|Ids], Avg_, Id_) :-
    findall(Veiculo, encomendaGerida(_, _, _, _, _, Veiculo, Id,_,_), ListaVeiculos),
    conta_veiculos(ListaVeiculos, Sum, Count),
    Count \= 0,
    mais_ecologico_aux(Ids, Avg_, Id_),
    Avg is Sum / Count,
    Avg =< Avg_.

% utiliza um sistema de pontos (Bicicleta -> 3, Mota -> 1, Carro -> 0) 
% para calcular a média (quanto maior, mais ecológico)
conta_veiculos([], 0, 0).
conta_veiculos(['Bicicleta'|T], Sum, Count) :-
    conta_veiculos(T, Sum_, Count_),
    Sum is Sum_ + 3,
    Count is Count_ + 1.
conta_veiculos(['Mota'|T], Sum, Count) :-
    conta_veiculos(T, Sum_, Count_),
    Sum is Sum_ + 1,
    Count is Count_ + 1.
conta_veiculos(['Carro'|T], Sum, Count) :-
    conta_veiculos(T, Sum, Count_),
    Count is Count_ + 1.



%------------------------------------------------
% Q2 - identificar que estafetas entregaram determinada(s) encomenda(s) a um determinado cliente;
quem_entegou([], _, []).
quem_entegou([IdEnc|IdsEnc], IdCli, [IdEstaf|IdsEstaf]) :-
    encomendaGerida(IdEnc, _, _, _, IdCli, _, IdEstaf,_,_),
    \+ member(IdEstaf, IdsEstaf),
    quem_entegou(IdsEnc, IdCli, IdsEstaf).
quem_entegou([IdEnc|IdsEnc], IdCli, IdsEstaf) :-
    encomendaGerida(IdEnc, _, _, _, IdCli, _, IdEstaf,_,_),
    member(IdEstaf, IdsEstaf),
    quem_entegou(IdsEnc, IdCli, IdsEstaf).    



%------------------------------------------------
% Q3 - identificar os clientes servidos por um determinado estafeta;
quem_recebeu(IdEstaf, IdsCli) :-
    findall(IdCli, encomendaGerida(_, _, _, _, IdCli, _, IdEstaf,_,_), IdsCli).



%------------------------------------------------
% Q4 - calcular o valor faturado pela Green Distribution num determinado dia;

faturado(Dia,Total) :-
    findall(Preco, encomendaGerida(_,_,_,_,_,_, Dia, Preco),Total),
            Faturacao is Total + Preco.
%-------------------------------------------------------------
% Q5 - Zona com maior volume de entregas
%encomendaGerida(Id, Peso, Vol, Prazo, Cliente, Veiculo, Estaf,Dia,Preco)

mais_volume(Ids, IdR) :-
    mais_volume_aux(LIds, -1, IdR).

mais_volume_aux([], _, null).
mais_volume_aux([Id],_, FreguesiaResultado).
mais_volume_aux([Id|Ids],Max, MFregusia) :-
    encontraFreguesia(findall(IdCliente, encomendaGerida(_,_,_,_,IdCliente,_,_,_,_),ListaFreguesias)),
    contaFreguesia(ListaFreguesias,Somatorio,Total),
    Total \= 0,
    mais_volume_aux(Ids,Max_,_),
    Max > Max_.
mais_volume_aux([Id|Ids],Max_,FreguesiaN) :-
    encontraFreguesia(findall(IdCliente, encomendaGerida(_,_,_,_,IdCliente,_,_,_,_),ListaFreguesias)),
    contaFreguesia(ListaFreguesias,Somatorio,Total),
    Total \= 0
    mais_volume_aux(Ids,Max_,FreguesiaN)
    Max =< Max_.



contaFreguesia([],Atual,0).
contaFreguesia([H|T],Atual,Count_):- contaFreguesia(T,Atual,Total), Count_ is 1+Total.
contaFreguesia([H|T],Atual,Total):- H \= Atual,contaFreguesia(T,Atual,Total).
    
