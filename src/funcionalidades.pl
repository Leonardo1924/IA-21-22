%Funcionalidades

:- include('predicadosAuxiliares.pl').
:- include('gestao.pl').

:-style_check(-singleton).

% a definir
% entrega(IdEnc, Nota).
:-dynamic(entrega/3).

%------------------------------------------------
% Q1 - identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico

mais_ecologico(IdR) :-
    findall(Id, estafeta(Id, _, _, _), LIds),
    mais_ecologico_aux(LIds, A, IdR).
 
mais_ecologico_aux([], -1, null). %lista vazia? []
mais_ecologico_aux([Id|Ids], Avg, IdR) :-
    findall(Veiculo, encomendaGerida(_, _, _, _, _, _, Veiculo, Id, _), ListaVeiculos),
    conta_veiculos(ListaVeiculos, Sum, Count),
    Count == 0,
    mais_ecologico_aux(Ids, Avg, IdR).
mais_ecologico_aux([Id|Ids], Avg, Id) :-
    findall(Veiculo, encomendaGerida(_, _, _, _, _, _, Veiculo, Id, _), ListaVeiculos),
    conta_veiculos(ListaVeiculos, Sum, Count),
    Count \= 0,
    mais_ecologico_aux(Ids, Avg_, _),
    Avg is Sum / Count,
    Avg > Avg_.
mais_ecologico_aux([Id|Ids], Avg_, Id_) :-
    findall(Veiculo, encomendaGerida(_, _, _, _, _, _, Veiculo, Id, _), ListaVeiculos),
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

quem_entregou([], _, []).
quem_entregou([IdEnc|IdsEnc], IdCli,[H|R]) :-
     write('Cliente : ') , write(IdCli), nl,
     write('Encomenda: '), write(IdEnc), nl, 
     bagof(IdEstaf, encomendaGerida(IdEnc, _, _, _, IdCli, _, _,IdEstaf, _),[H|ListaIdEstaf]),
     write('Estafeta :'), write(H),nl,
     quem_entregou(IdsEnc, IdCli, R).

   

%------------------------------------------------
% Q3 - identificar os clientes servidos por um determinado estafeta

quem_recebeu(IdEstaf, [IdCli|IdsCli]) :-
    bagof(IdCli,encomendaGerida(_, _, _, _, IdCli, _, _,IdEstaf,_), IdsCli),
    write(IdCli).


%------------------------------------------------
% Q4 - calcular o valor faturado pela Green Distribution num determinado dia

faturado((M,D),Total) :-
    write('Dia : '), write((M,D)), nl,
    findall(Preco, encomendaGerida(_,_,_,_,_,(M,D),_,_,Preco), ListaPrecos),
    write('Preco : '), write(ListaPrecos),nl,
    sum_list(ListaPrecos,Total).

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
    findall(IdEnc, encomendaGerida(IdEnc, _, _, _, _, _, _, IdEstaf, _), IdsEnc),
    map_id_to_nota(IdsEnc, Notas),
    write('Lista '), write(Notas),nl,
    sum_list(Notas, Sum),
    length(Notas, Count),
	write(Count),
    Count > 0,
    Avg is Sum / Count.

map_id_to_nota([], []).
map_id_to_nota([IdEnc|IdsEnc], [N|Notas]) :-
    findall(Nota,entrega(IdEnc, 1, Nota),[N|Notas]),
    write(N),nl,
    map_id_to_nota(IdsEnc, Notas).
map_id_to_nota([IdEnc|IdsEnc], Notas) :-
    findall(Nota, entrega(IdEnc, 1, Nota), []),
    map_id_to_nota(IdsEnc, Notas).

%-------------------------------------------------------------
% Q7 - identificar o número total de entregas pelos diferentes meios de transporte, 
%      num determinado intervalo de tempo


  
total_entregas_data_veiculo((MI,DI),(MF,DF),(B, M, C),ListaFinal) :-
  findall(Veiculo, (encomendaGerida(_, _, _, _, _, (M,D), Veiculo, _, _), entre((MI,DI),(M,D),(MF,DF))),ListaInicial),
  reverse(ListaInicial,L2),
  fix(L2,ListaFinal),
  write(L2),
  write(ListaFinal),
  count_veiculos(ListaFinal,B,M,C).
  
  
fix([H|T],T).
 
count_veiculos([], 0, 0, 0).
count_veiculos(['Bicicleta'|T], B, M, C) :- 
    count_veiculos(T,B_,M,C),
    B is B_+1.
    

count_veiculos(['Mota'|T], B, M, C) :-
    count_veiculos(T,B,M_,C),
    M is M_+1.


count_veiculos(['Carro'|T], B, M, C) :-
    count_veiculos(T,B,M,C_),
    C is C_ + 1.



entre((M1, D1), (M,D), (M2, D2)) :-
    M1 =:= M,
    M =< M2,
    D1 =< D,
    D =< D2. 

entre((M1, D1), (M,D), (M2, D2)) :-
    M =:= M2,
    M1 =< M,
    D1 =< D,
    D =< D2.

%-------------------------------------------------------------
% Q8 - identificar o número total de entregas pelos estafetas, num determinado intervalo de tempo

total_entregas_data((MI,DI), (MF,DF), R) :-
    findall(IdEst,(encomendaGerida(_, _, _, _, _, (M,D), _,IdEst, _), entre((MI,DI), (M,D), (MF,DF))),ListaIds),
    fix(ListaIds,X),
    length(X, R).

%-------------------------------------------------------------
% Q9 - calcular o número de encomendas entregues e não entregues pela Green Distribution, num determinado período de tempo

total_entregas((M1,D1),(M2,D2),(R1,R2)) :-
    findall(IdEncomenda, (encomendaGerida(IdEncomenda, _, _, _, _, (M,D),_,_,_) ,entre((M1,D1),(M,D),(M2,D2))),Resultado),
   	sort(Resultado,Resultado1),
    ler_encomenda(Resultado1,Flags),
    conta_entregas(Flags,R1,R2).


ler_encomenda([],[]).
ler_encomenda([Id|Ids],[Flag2|Final]) :- 
   findall(Flag,entrega(Id,Flag,_),[Flag2|Tail]), 
   ler_encomenda(Ids,Final).


conta_entregas([],0,0).
conta_entregas([0|T], Count0, Count1) :-
    conta_entregas(T,Count0_, Count1),
    Count0 is Count0_ + 1.

conta_entregas([1|T],Count0, Count1) :-
    conta_entregas(T,Count0, Count1_),
    Count1 is Count1_ + 1.

conta_entregas([X|T], Count0, Count1) :- 
    X \= 1, 
    X\= 0, 
    conta_entregas(T, Count0, Count1).

%-------------------------------------------------------------
% Q10 - calcular o peso total transportado por estafeta num determinado dia

peso_transportado((M,D), Total) :-
    findall(Peso, encomendaGerida(_, Peso, _, _, _, (M,D), _, _, _), ListaPesos),
    sum_list(ListaPesos, Total).
