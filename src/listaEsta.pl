%estafeta(id de estafeta, nome, contacto, flag)
estafeta(100, 'Abílio Pereira', 968574572,'base').
estafeta(200, 'Maria Costa'   , 925876447,'naobase').
estafeta(300, 'Sandra Silva'  , 957857458,'naobase').
estafeta(400, 'Pedro Rocha'   , 923454374,'base').
estafeta(500, 'Madalena Dias' , 934543456,'naobase').
estafeta(600, 'Paulo Marques' , 923432312,'base').
estafeta(700, 'António Soares', 964332124, 'naobase'). 

encontraEstafetaLivre(IdEstafeta) :-
    estafeta(IdEstafeta, _, _, 'base').


listaEstafetas([IdEstafeta|Result]):- 
   encontraEstafetaLivre(IdEstafeta), 
   retract(estafeta(IdEstafeta, _, _, _)),
   assert(estafeta(IdEstafeta, _, _,'naobase')),
   listaEstafetas(Result).

listaEstafetas([]).

main:- listaEstafetas(L), 
	write(L).