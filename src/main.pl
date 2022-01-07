:-include('funcionalidades.pl').
:-include('predicadosAuxiliares').


%MENU


main :-
    gerir,
    repeat,
    nl,nl,
    write('---------------------------------------------MENU-----------------------------------------------'), nl,
    write('|                 1. Estafeta mais ecologico                                                   |'), nl,
    write('|                 2. Estafeta que realizaram entregas                                          |'), nl,
    write('|                 3. Cliente servido por Estafeta A                                            |'), nl,
    write('|                 4. Valor faturado no Dia X                                                   |'), nl,
    write('|                 5. Zona com maior volume de entregas                                         |'), nl,
    write('|                 6. Classificacao media de satisfacao para o estafeta A                       |'), nl,
    write('|                 7. Numero total de entregas diferentes transportes num intervalo de tempo X  |'), nl,
    write('|                 8. Numero total de entregas pelos estafetas, num intervalo de tempo X        |'), nl,
    write('|                 9. Numero de encomendas entregues Vs nao entregues, num intervalo de tempo X |'), nl,
    write('|                 10. Peso total transportado no dia X                                         |'), nl,
    write('|                 11. Selecionar que encomenda foi entregue                                    |'), nl,
    write('|                 12. Indicar chegada a empresa                                                |'), nl,
    write('|                 13. Classificar entrega                                                      |'), nl,
    write('|                 14. Gerir as entregas                                                        |'), nl,
    write('|                 0. Exit                                                                      |'), nl,
    write('------------------------------------------------------------------------------------------------'), nl,nl,
    write('Choose '),
    read(Z), nl,
    ( Z = 0 -> !, fail ; true ),
    nl,nl,
    action_for(Z),
    fail.

action_for(X) :- 
	write('Action for '), 
	write(X), nl.

%Funcionalidades

action_for(1) :-
    mais_ecologico(Id),
    write('Estafeta mais ecológico: '),
    write(Id), nl.

auxiliar_number([],[]).
auxiliar_number([H|T],[H1|T1]) :- 
	atom_number(H,H1),
	write(H1), nl,
	auxiliar_number(T,T1).





action_for(2) :-
    write('Insira encomendas separadas por virgula: '),
    read(Str),nl,
    split_string(Str, ",", "\n ", Lista),
    auxiliar_number(Lista,ListaAtomos),
   
    write('Insira cliente: '),
    read(Id),nl,

    quem_entregou(ListaAtomos, Id,ListaEstafetas),
    write('Resposta : '), write(ListaEstafetas),nl.
 
   


action_for(3) :-
    write('Inserir estafeta: '),
    read(IdEstafeta),nl,
    write('Estafeta : '), write(IdEstafeta), nl,
    quem_recebeu(IdEstafeta,IdsCli),
    sort(IdsCli,IdsClientes),
    write('Resposta : '), write(IdsClientes), nl.

action_for(4) :-
    write('Insira o mes (2 digitos)'),
    read(M),nl,
    write('Insira o dia (2 digitos)'),
    read(D),nl,
 
    faturado((M,D),Total),
    write('Valor Faturado :'),
    write(Total), nl.

action_for(5) :-
    mais_volume(FregR),
    write(FregR),nl.

action_for(6) :-
    write('Insira o estafeta: '),
    read(Id),nl,
    class_media(Id, Avg),
    write(Avg), nl.

action_for(7) :-
    write('Insira o 1o mes (2 digitos)'),
    read(MI),nl,
    write('Insira o 1o dia (2 digitos)'),
    read(DI),nl,
    write('Insira o 2o mes (2 digitos)'),
    read(MF),nl,
    write('Insira o 2o dia (2 digitos)'),
    read(DF),nl,
    total_entregas_data_veiculo((MI,DI),(MF,DF),(B,M,C),Lista).
   % write('Lista :'), write(Lista).

  %  write('Bicicletas: '), write(B), nl,
   % write('Motas: '), write(M), nl,
    %write('Carros: '), write(C), nl.

action_for(8) :-
    write('Insira o 1o mês (2 digitos)'),
    read(M1),nl,
    write('Insira o 1o dia (2 digitos)'),
    read(D1),nl,
    write('Insira o 2o mês (2 digitos)'),
    read(M2),nl,
    write('Insira o 2o dia (2 digitos)'),
    read(D2),nl,
 %   total_entregas_data((M1,D1), (M2,D2), (B,M,C)),
    write('Bicicletas : '), write(B), nl,
    write('Motas : '), write(M), nl,
    write('Carros : '), write(C), nl.

action_for(9) :-
    total_entregas(R1, R2),
    write('Nao entregues: '), write(R1), nl,
    write('Entregues: '), write(R2), nl.

action_for(10) :-
    write('Insira o mes (2 digitos)'),
    read(M),
    write('Insira o dia (2 digitos): '),
    read(D),
    peso_transportado((M,D), T),
    write(T), nl.

action_for(11) :-
    write('Inserir id de encomenda: '), nl,
    read(Id),
    update_Estentrega(Id).

action_for(12) :-
    write('Inserir o seu id: '), nl,
    read(Id),
    update_estafeta(Id).

action_for(13) :-
    write('Insira a encomenda a classificar: '),
    read(Id),
    write('Insera a nota: '),
    read(Nota),
    classificar_entrega(Id, Nota),
    findall(Nota,entrega(_,_,Nota),Notas),
    write(Notas).

action_for(14) :-
    write('----------------------------------------Procuras------------------------------------------'), nl, 
    write('|                             1. DFs                                                      |'), nl,
    write('|                             2. BFs                                                      |'), nl,
    write('|                             3. Gulosa                                                   |'), nl,
    write('|                             4. A*                                                       |'), nl,
    write('------------------------------------------------------------------------------------------'), nl,
    read(Flag),
    percorreEncomendas(Ids,Pesos,Prazos,Velocidades,Freguesias,Distancias,Flag,Freguesias,Custos).
    
