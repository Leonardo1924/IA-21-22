%Funcionalidades

:- include('predicadosAuxiliares.pl').
:- include('baseDeConhecimento.pl').
:- include('gestao.pl').

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

faturado(Dia, Total) :-
    findall(Preco, encomendaGerida(_,_,_,_,_,_,_, Dia, Preco), ListaPrecos),
    sum_list(ListaPrecos, Total).

%-------------------------------------------------------------
% Q5 - Zona com maior volume de entregas
%encomendaGerida(Id, Peso, Vol, Prazo, Cliente, Veiculo, Estaf, Dia, Preco)
%cliente(idºde cliente, nome, nif, rua, porta, freguesia, telemovel)

mais_volume(FregR) :-
    findall((IdCliente, Volume), encomendaGerida(_, _, Volume, _, IdCliente, _, _, _, _), TuplosIdVol),
    map_id_to_freg(TuplosIdVol, TuplosFregVol),
    max_vol(TuplosFregVol, TuplosFregVol, -1, FregR).

map_id_to_freg([], []).
map_id_to_freg([(IdCli, V)|T1], [(Freg, V)|T2]) :-
    cliente(IdCli, _, _, _, _, Freg, _),
    map_id_to_freg(T1, T2).

max_vol(_, [], -1, null).
max_vol(L, [(Freg, _)|T], CurrV, Freg) :-
    max_vol(L, T, CurrV_, _),
    soma_volume_por_freg(L, Freg, CurrV),
    CurrV > CurrV_.
max_vol(L, [(Freg, _)|T], CurrV_, Freg_) :-
    max_vol(L, T, CurrV_, Freg_),
    soma_volume_por_freg(L, Freg, CurrV),
    CurrV =< CurrV_.

soma_volume_por_freg([], _, 0).
soma_volume_por_freg([(Freg, V)|T], Freg, TotalV) :-
    soma_volume_por_freg(T, Freg, TotalV_),
    TotalV is TotalV_ + V.
soma_volume_por_freg([(F, V)|T], Freg, TotalV) :-
    F \= Freg,
    soma_volume_por_freg(T, Freg, TotalV).
