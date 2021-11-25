%MENU

:- consult('gestao.pl').
:- consult('funcionalidades.pl').



main :-
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
    write('|                 10. Peso total transportado no dia X                                         |'),nl,
    write('|                 0. Exit                                                                      |'), nl,
    write('------------------------------------------------------------------------------------------------'), nl,nl,
    write('Choose : '),
    read(Z),
    ( Z = 0 -> !, fail ; true ),
    nl,nl,
    action_for(Z),
    fail.

%Funcionalidades
action_for(1) :-
    function1(Max,IdNomes),
    write('Estafeta: '),
    write(IdNomes),nl,
    write('Número de Vezes:'),
    write(Max),
    nl.

action_for(2) :-
function2([2,3,4],2,Lista).
    write('Cliente : '),

    write(L), nl.

action_for(3) :-
    function3(L),
    write(L), nl.

action_for(4) :-
    function4(L),
    write(L), nl.

action_for(5) :-
    function5(L),
    write(L),nl.

action_for(6) :-
    function6(L),
    write(L),nl.

action_for(7) :-
    function7(L),
    write(L),nl.

action_for(8) :-
    function8(L),
    write(L),nl.

action_for(9) :-
    function9(Max,IdNomes),!,
    write('Estafeta: '),
    write(IdNomes),nl,
    write('Nº de vezes: '),
    write(Max),nl.

action_for(10) :-
    function10(L),
    write(L), nl.