:-set_prolog_flag(answer_write_options,[max_depth(0)]).

:-style_check(-singleton).
:-style_check(-discontiguous).

:-dynamic(estafeta/4).

%Base do Conhecimento

%--------------Clientes--------------
%cliente(id de cliente, nome, NIF, rua, porta, freguesia, telemovel)
cliente(1,'Jose Andrade'      ,123469696,'Rua dos Rios','2','Sao Vitor',969798321).
cliente(2,'Rafael Pereira'    ,123456789,'Rua dos Sinos','5','Sao Vicente',966969698).
cliente(3,'Maria Silva'       ,987654321,'Rua das Teclas','8','Ferreiros',969798231).
cliente(4,'Rui Lopes'         ,123789400,'Rua da Universidade','12','Gualtar',929395961).
cliente(5,'Ana Ferreira'      ,134567890,'Rua do Mato','7','Nogueiro',912442421).
cliente(6,'Pedro Teixeira'    ,023462327,'Rua do Exercito','2','Sao Vitor',961123501).
cliente(7,'Henrique Oliveira' ,123469696,'Avenida do Carmo','2','Gualtar',934338321).
cliente(8,'Leonardo Henriques',255225571,'Avenida da Trindade','2','Sao Vitor',969215121).

%---------Encomendas---------------
%encomenda(id de encomenda, peso, volume, prazo, idCliente, dataInicial)
%prazo: 0 -> imediato; 24 -> 1 dia
encomenda(1,70,20,0,2,(01,01)).
encomenda(2,15,10,2,2,(01,02)).
encomenda(3,1,23,6,8,(01,03)).

%--------Estafeta-------------------
%estafeta(id de estafeta, nome, contacto, flag)
estafeta(1, 'Abilio Pereira', 968574572,'base').
estafeta(2, 'Maria Costa'   , 925876447,'naobase').
estafeta(3, 'Sandra Silva'  , 957857458,'naobase').
estafeta(4, 'Pedro Rocha'   , 923454374,'base').
estafeta(5, 'Madalena Dias' , 934543456,'naobase').
estafeta(6, 'Paulo Marques' , 923432312,'base').
estafeta(7, 'Antonio Soares', 964332124, 'naobase').

%freguesias(FreguesiaInicial, FreguesiaFinal, Distancia)
freguesias( grafo([adaufe,maximinos,saoPedro,palmeira,real,nogueira,saoVitor,saoLazaro,ferreiros,frossos, gualtar,nogueiro,saoVicente,navarra],
    [aresta(adaufe, gualtar, 8),
    aresta(adaufe, palmeira, 12),
    aresta(adaufe, saoVitor, 7),
    aresta(saoVicente, adaufe, 7 ),
    aresta(navarra, adaufe, 10 ),
    aresta(saoLazaro, maximinos, 6),
    aresta(ferreiros, maximinos, 7),
    aresta(maximinos, real, 11),
    aresta(maximinos, saoVicente, 3),
    aresta(saoPedro, gualtar, 12),
    aresta(nogueiro, saoPedro, 10),
    aresta(saoPedro, navarra, 11),
    aresta(palmeira, real, 14),
    aresta(frossos, palmeira, 8),
    aresta(palmeira, saoVicente, 8),
    aresta(real, saoVicente, 8),
    aresta(real, frossos, 13),
    aresta(real, ferreiros,9),
    aresta(saoLazaro, nogueira, 6),
    aresta(nogueira, saoVitor, 8),
    aresta(nogueira, nogueiro, 6),
    aresta(saoVitor, gualtar, 7),
    aresta(saoVitor, saoLazaro, 3),
    aresta(saoVicente, saoVitor, 4),
    aresta(saoVitor, nogueiro, 8),
    aresta(saoLazar, saoVicente, 6),
    aresta(gualtar, nogueiro, 4)])).

% estima(nodo, estimativaCusto).

estima(adaufe,10).
estima(maximinos, 0).
estima(saoPedro, 26).
estima(palmeira, 11).
estima(real, 11). 
estima(nogueira, 12).
estima(saoVitor,7).
estima(saoLazaro, 6).
estima(gualtar,14).
estima(ferreiros, 7).
estima(frossos, 24).
estima(saoVicente,3).
estima(saoLazaro,6).
estima(nogueiro,18).
estima(navarra,21).