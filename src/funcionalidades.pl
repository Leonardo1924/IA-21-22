%Funcionalidades

:- include('predicadosAuxiliares.pl').
:- include('baseDeConhecimento.pl').
:- include('gestao.pl').

:-style_check(-singleton).

%------------------------------------------------
% Q1 - identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico

mais_ecologico(IdR) :-
    findall(Id, estafeta(Id, _, _, _), LIds),
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
% Q2 - identificar que estafetas entregaram determinada(s) encomenda(s) a um determinado cliente

quem_entegou([], _, []).
quem_entegou([IdEnc|IdsEnc], IdCli, [IdEstaf|IdsEstaf]) :-
    encomendaGerida(IdEnc, _, _, _, IdCli, _, IdEstaf, _, _),
    \+ member(IdEstaf, IdsEstaf),
    quem_entegou(IdsEnc, IdCli, IdsEstaf).
quem_entegou([IdEnc|IdsEnc], IdCli, IdsEstaf) :-
    encomendaGerida(IdEnc, _, _, _, IdCli, _, IdEstaf, _, _),
    member(IdEstaf, IdsEstaf),
    quem_entegou(IdsEnc, IdCli, IdsEstaf).    

%------------------------------------------------
% Q3 - identificar os clientes servidos por um determinado estafeta

quem_recebeu(IdEstaf, IdsCli) :-
    findall(IdCli, encomendaGerida(_, _, _, _, IdCli, _, IdEstaf,_,_), IdsCli).

%------------------------------------------------
% Q4 - calcular o valor faturado pela Green Distribution num determinado dia

faturado(Dia, Total) :-
    findall(Preco, encomendaGerida(_,_,_,_,_,_,_, Dia, Preco), ListaPrecos),
    sum_list(ListaPrecos, Total).

%-------------------------------------------------------------
% Q5 - Zona com maior volume de entregas

mais_volume(FregR) :-
    findall(IdCliente, encomendaGerida(_, _, _, _, IdCliente, _, _, _, _), Ids),
    map_id_to_freg(Ids, Fregs),
    max_freg(Fregs, Fregs, _, FregR).

map_id_to_freg([], []).
map_id_to_freg([IdCli|T1], [Freg|T2]) :-
    cliente(IdCli, _, _, _, _, Freg, _),
    map_id_to_freg(T1, T2).

max_freg(_, [], -1, null).
max_freg(L, [Freg|T], Curr, Freg) :-
    max_freg(L, T, Curr_, _),
    conta_freguesias(L, Freg, Curr),
    Curr > Curr_.
max_freg(L, [Freg|T], Curr_, Freg_) :-
    max_freg(L, T, Curr_, Freg_),
    conta_freguesias(L, Freg, Curr),
    Curr =< Curr_.

conta_freguesias([], _, 0).
conta_freguesias([Freg|T], Freg, Count) :-
    conta_freguesias(T, Freg, Count_),
    Count is Count_ + 1.
conta_freguesias([Freg|T], Freg_, Count) :-
    conta_freguesias(T, Freg_, Count),
    Freg \= Freg_.

%-------------------------------------------------------------
% Q6 - calcular a classificação média de satisfação de cliente para um determinado estafeta 

class_media(IdEstaf, Avg) :-
    findall(IdEnc, encomendaGerida(IdEnc, _, _, _, _, _, IdEstaf, _, _), IdsEnc),
    map_id_to_nota(IdsEnc, Notas),
    sum_list(Notas, Sum),
    length(Notas, Count),
    Count > 0,
    Avg is Sum / Count.

map_id_to_nota([], []).
map_id_to_nota([IdEnc|IdsEnc], [Nota|Notas]) :-
    entrega(IdEnc, Nota),
    map_id_to_nota(IdsEnc, Notas).
map_id_to_nota([IdEnc|IdsEnc], Notas) :-
    \+ entrega(IdEnc, _),
    map_id_to_nota(IdsEnc, Notas).

%-------------------------------------------------------------
% Q7 - identificar o número total de entregas pelos diferentes meios de transporte, 
%      num determinado intervalo de tempo

entre((M1, _), (M, _), (M2, _)) :-
    M1 < M2,
    M1 < M,
    M < M2.
entre((M1, D1), (M, D), (M2, D2)) :-
    M1 =:= M,
    M < M2,
    D1 < D,
    D2 < D.
entre((M1, D1), (M, D), (M2, D2)) :-
    M =:= M2,
    M1 < M,
    D1 < D,
    D < D2.

%-------------------------------------------------------------
% Q10 - Peso total transportado no dia X 

peso_transportado(Dia, Total) :-
    findall(Peso, encomendaGerida(_, Peso, _, _, _, _, _, Dia, _), ListaPesos),
    sum_list(ListaPesos, Total).
