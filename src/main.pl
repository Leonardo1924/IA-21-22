:-include('funcionalidades.pl').


%MENU

main :-
    init,
    repeat,
    nl,nl,
    write('---------------------------------------------MENU-----------------------------------------------'), nl,
    write('|                 1. Estafeta mais ecologico                                                   |'), nl,
    write('|                 2. Estafeta entrega a encomenda A ao cliente B                               |'), nl,
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
    write('|                 0. Exit                                                                      |'), nl,
    write('------------------------------------------------------------------------------------------------'), nl,nl,
    write('Choose : '),
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

action_for(2) :-
    write('Insira encomendas separadas por virgula: '),
    read(Str),nl,
    split_string(Str, ",", "\n ", L),
    write('Insira cliente: '),
    read(Id),nl,
    quem_entregou(L, Id, R),
    write(R), nl.

action_for(3) :-
    write('Inserir estafeta: '),
    read(Id),nl,
    quem_recebeu(Id, IdsCli),
    write(IdsCli), nl.

action_for(4) :-
    write('Insira o mes (2 digitos)'),
    read(M),nl,
    write('Insira o dia (2 digitos)'),
    read(D),nl,
    faturado((M,D), Total),
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
    read(M1),nl,
    write('Insira o 1o dia (2 digitos)'),
    read(D1),nl,
    write('Insira o 2o mês (2 digitos)'),
    read(M2),nl,
    write('Insira o 2o dia (2 digitos)'),
    read(D2),nl,
    total_entregas_data_veiculo((M1,D1), (M2,D2), (B,M,C)),
    write('Bicicletas: '), write(B), nl,
    write('Motas: '), write(M), nl,
    write('Carros: '), write(C), nl.

action_for(8) :-
    write('Insira o 1o mês (2 digitos)'),
    read(M1),nl,
    write('Insira o 1o dia (2 digitos)'),
    read(D1),nl,
    write('Insira o 2o mês (2 digitos)'),
    read(M2),nl,
    write('Insira o 2o dia (2 digitos)'),
    read(D2),nl,
    total_entregas_data((M1,D1), (M2,D2), R),
    write(R), nl.

action_for(9) :-
    total_entregas(R1, R2),
    write('Nao entregues: '), write(R1), nl,
    write('Entregues: '), write(R2), nl.

action_for(10) :-
    write('Insira o mes (2 digitos)'),
    read(M),
    write('Insira o dia (2 digitos)'),
    read(D),
    peso_transportado((M,D), T),
    write(T), nl.

action_for(11) :-
    write('Inserir id de encomenda: '), nl,
    read(Id),
    update_entrega(Id).

action_for(12) :-
    write('Inserir o seu id: '), nl,
    read(Id),
    update_entrega(Id).

action_for(13) :-
    write('Insira a encomenda a classificar: '),
    read(Id),
    write('Insera a nota: '),
    read(Nota),
    classificar_entrega(Id, Nota).
