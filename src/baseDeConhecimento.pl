:-set_prolog_flag(discontiguous_warnings,off).
:-set_prolog_flag(single_var_warnings,off).
:-set_prolog_flag(answer_write_options,[max_depth(0)]).

:-dynamic (cliente/7).
:-dynamic (estafeta/4).
:-dynamic (encomenda/5).



%Base do Conhecimento

%--------------Clientes--------------
%cliente(idºde cliente, nome, nif,rua,porta,freguesia, telemovel)
cliente(1,'Jose Andrade'      ,123469696,'Rua dos Rios','2','svitor',969798321).
cliente(2,'Rafael Pereira'    ,123456789,'Rua dos Sinos','5','svicente',966969698).
cliente(3,'Maria Silva'       ,987654321,'Rua das Teclas','8','celeiros',969798231).
cliente(4,'Rui Lopes'         ,123789400,'Rua da Universidade','12','gualtar',929395961).
cliente(5,'Ana Ferreira'      ,134567890,'Rua do Mato','7','nogueira',912442421).
cliente(6,'Pedro Teixeira'    ,023462327,'Rua do Exercicito','2','svitor',961123501).
cliente(7,'Henrique Oliveira' ,123469696,'Avenida do Carmo','2','gualtar',934338321).
cliente(8,'Leonardo Henriques',255225571,'Avenida da Trindade','2','svitor',969215121).


%---------Encomedas---------------
%encomenda(id,peso,volume,prazo, idCliente) prazo: 0- imediato, 24-1 dia
encomenda(1,5,20,0,2).
encomenda(2,15,10,2,7).
encomenda(3,10,23,6,8).
encomenda(4,20,30,24,1).
encomenda(5,30,45,0,2).
encomenda(6,24,43,2,4).
encomenda(7,55,23,6,3).
encomenda(8,40,24,6,6).
encomenda(9,30,13,24,5).
encomenda(10,100,122,24,3).

%--------Estafeta-------------------
%estafeta(idºde estafeta,nome,contacto,flag)
estafeta(1, 'Abílio Pereira', 968574572,'base').
estafeta(2, 'Maria Costa'   , 925876447,'naobase').
estafeta(3, 'Sandra Silva'  , 957857458,'naobase').
estafeta(4, 'Pedro Rocha'   , 923454374,'base').
estafeta(5, 'Madalena Dias' , 934543456,'naobase').
estafeta(6, 'Paulo Marques' , 923432312,'base').
estafeta(7, 'António Soares', 964332124, 'naobase'). 