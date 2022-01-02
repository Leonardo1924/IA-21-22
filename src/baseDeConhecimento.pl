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
freguesias( grafo(['Adaufe','Maximinos','Sao Pedro','Palmeira','Real','Nogueira','Sao Vitor','Sao Lazaro','Ferreiros', 'Frossos', 'Gualtar','Nogueiro','Sao Vicente','Navarra'],
    [aresta('Adaufe', 'Gualtar', 8),
     aresta('Adaufe', 'Palmeira', 12),
     aresta('Adaufe','Sao Vitor', 7),
     aresta('Adaufe', 'Sao Vicente', 7),
     aresta('Adaufe', 'Navarra', 10),
     aresta('Maximinos', 'Sao Lazaro', 6),
     aresta('Maximinos','Ferreiros', 7),
     aresta('Maximinos', 'Real', 11),
     aresta('Maximinos','Sao Vicente', 3),
     aresta('Sao Pedro', 'Gualtar', 12),
     aresta('Sao Pedro','Nogueiro', 10),
     aresta('Sao Pedro','Navarra', 11),
     aresta('Palmeira','Real', 14),
     aresta('Palmeira','Frossos', 8),
     aresta('Palmeira','Sao Vicente', 8),
     aresta('Real','Sao Vicente', 10),
     aresta('Real','Frossos', 13),
     aresta('Real','Ferreiros', 9),
     aresta('Nogueira','Sao Lazaro', 6),
     aresta('Nogueira','Sao Vitor', 8),
     aresta('Nogueira','Nogueiro', 6),
     aresta('Sao Vitor','Gualtar', 7),
     aresta('Sao Vitor','Sao Lazaro', 3),
     aresta('Sao Vitor','Sao Vicente', 4),
     aresta('Sao Vitor','Nogueiro', 8),
     aresta('Sao Lazaro','Sao Vicente', 6),
     aresta('Gualtar','Nogueiro', 4)])).

% node(nodo, estimativaCusto).

node('Maximinos', 0).
node('Real', 11).
node('Ferreiros', 7).
node('Frossos', 19).
node('Palmeira', 11).
node('Sao Vicente', 3).
node('Sao Lazaro', 6).
node('Adaufe', 10).
node('Sao Vitor', 7).
node('Nogueira', 12).
node('Nogueiro', 15).
node('Gualtar', 14).
node('Navarra', 20).
node('Sao Pedro', 25).