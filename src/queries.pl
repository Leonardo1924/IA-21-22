:-consult('gestao.pl').

:-style_check(-singleton).

%------------------------------------------------
% identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico;
mais_ecologico(LIds, IdR) :-
    mais_ecologico_aux(LIds, -1, IdR).

mais_ecologico_aux([], _, null).
mais_ecologico_aux([Id], _, Id).
mais_ecologico_aux([Id|Ids], Avg, Id) :-
    findall(Veiculo, encomendaGerida(_, _, _, _, _, Veiculo, Id), ListaVeiculos),
    conta_veiculos(ListaVeiculos, Sum, Count),
    Count \= 0,
    mais_ecologico_aux(Ids, Avg_, _),
    Avg is Sum / Count,
    Avg > Avg_.
mais_ecologico_aux([Id|Ids], Avg_, Id_) :-
    findall(Veiculo, encomendaGerida(_, _, _, _, _, Veiculo, Id), ListaVeiculos),
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
% identificar que estafetas entregaram determinada(s) encomenda(s) a um determinado cliente;
quem_entegou([], _, []).
quem_entegou([IdEnc|IdsEnc], IdCli, [IdEstaf|IdsEstaf]) :-
    encomendaGerida(IdEnc, _, _, _, IdCli, _, IdEstaf),
    \+ member(IdEstaf, IdsEstaf),
    quem_entegou(IdsEnc, IdCli, IdsEstaf).
quem_entegou([IdEnc|IdsEnc], IdCli, IdsEstaf) :-
    encomendaGerida(IdEnc, _, _, _, IdCli, _, IdEstaf),
    member(IdEstaf, IdsEstaf),
    quem_entegou(IdsEnc, IdCli, IdsEstaf).    



%------------------------------------------------
% identificar os clientes servidos por um determinado estafeta;
quem_recebeu(IdEstaf, IdsCli) :-
    findall(IdCli, encomendaGerida(_, _, _, _, IdCli, _, IdEstaf), IdsCli).



%------------------------------------------------
% calcular o valor faturado pela Green Distribution num determinado dia;
