:-set_prolog_flag(discontiguous_warnings,off).
:-set_prolog_flag(single_var_warnings,off).
:-set_prolog_flag(answer_write_options,[max_depth(0)]).

:-dynamic (cliente/7).
:-dynamic (estafeta/).
:-dynamic (encomenda/11).
:-dynamic (veiculos/3).


%Base DO Conhecimento

%--------------Clientes--------------
%cliente(idºde cliente, nome, nif,rua,porta,freguesia,lista de encomendas realizadas,lista de encomendas atuais, telemovel)
cliente(1,'Jose'    ,123469696,'Rua dos Rios','2','svitor',,         ,969798321).
cliente(2,'Rafael'  ,123456789,'Rua dos Sinos','5','svicente',,      ,966969698).
cliente(3,'Maria'   ,987654321,'Rua das Teclas','8','celeiros',,     ,969798231).
cliente(4,'Rui'     ,123789400,'Rua da Universidade','12','gualtar',,,929395961).
cliente(5,'Ana'     ,134567890,'Rua dos Mato','7','nogueira',,       ,912442421).
cliente(6,'Pedro'   ,023462327,'Rua do Exercicito','2','svitor',,   ,961123501).
cliente(7,'Henrique',123469696,'Avenida do Carmo','2','gualtar',,    ,934338321).
cliente(8,'Leo'     ,255225571,'Avenida da Trindade','2','svitor',,  ,969215121).


%---------Encomedas---------------
%encomenda(id,peso,volume,prazo,idºestafeta,idºcliente,de,para,preço,veiculo,entrega)
encomenda(1,5,)
encomenda(2,15,)
encomenda(3,10,)
encomenda(4,20,)
encomenda(5,30,)
encomenda(6,24,)
encomenda(7,55,)
encomenda(8,40,)
encomenda(9,30,)
encomenda(10,100,)

%--------Estafeta-------------------
%estafeta(idºde estafeta,nome,contacto,historico,avaliação,proxima encomenda)

















%----------------Mapa----------------


freguesia( grafo([svitor , maximinos , svicente, nogueira, real, ferreiros, lomar, merlim, gualtar],
  [aresta(svitor, svicente, 871),
   aresta(svitor, gualtar, 477),
   aresta(svitor, nogueira, 1583),
   aresta(maximinos, ferreiros, 2365),
   aresta(maximinos, real, 2493),
   aresta(maximinos, svicente, 2654),
   aresta(maximinos, lomar, 480),
   aresta(svicente, real, 922),
   aresta(svicente, nogueira, 2953),
   aresta(nogueira, lomar, 2304),
   aresta(real, merlim, 337),
   aresta(real, ferreiros, 728),
   aresta(viseu, coimbra, 388),
   aresta(viseu,guarda, 2613),] 
)).

% random number genarator fez ser mais facil ir por duas ruas em vez de ir pela principal por isso temos que ter cuidado com isso (rios->trindade->camoes)
ruaSvitor( grafo([rua_dos_rios, rua_do_exercicito, avenida_da_trindade, rua_do_taxa, rua_de_camoes],
  [aresta(rua_dos_rios, rua_do_exercicito, 282),
   aresta(rua_dos_rios, avenida_da_trindade, 232),
   aresta(rua_dos_rios, rua_do_taxa, 150),
   aresta(rua_dos_rios, rua_de_camoes, 415),
   aresta(avenida_da_trindade, rua_de_camoes, 50),
   aresta(rua_do_taxa, rua_do_exercicito, 139),
   aresta(rua_de_camoes,rua_do_taxa, 39),]
)).

ruaMaximinos( grafo([rua_de_caires, avenida_spedro, rua_padre_cruz, avenida_domHenrique, largo_do_beco, travessa_das_laranjeiras],
  [aresta(rua_de_caires, avenida_spedro, 690),
   aresta(rua_de_caires, avenida_domHenrique, 420),
   aresta(avenida_spedro, rua_padre_cruz, 140),
   aresta(avenida_spedro, avenida_domHenrique, 120),
   aresta(avenida_domHenrique, largo_do_beco, 134),
   aresta(largo_do_beco,travessa_das_laranjeiras, 55),]
)).

ruaSvicente(grafo([rua_do_carvalhal, rua_dos_sinos, rua_de_espanha, rua_santa_teresa],
  [aresta(rua_do_carvalhal, rua_dos_sinos, 74),
   aresta(rua_do_carvalhal, rua_de_espanha, 405),
   aresta(rua_do_carvalhal, rua_santa_teresa, 199),]
)).

ruasNogueira(grafo([],)).


