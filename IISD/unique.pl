del(_,[],[]):-!.
del(H,[H|T],Tr):-del(H,T,Tr),!.
del(H,[Hr|T],[Hr|Tr]):-del(H,T,Tr).
memb(H,L1,L2):- memb(H,L1),!;memb(H,L2).
memb(H,[H|_]):-!.
memb(H,[_|T]):- memb(H,T).
unic([],L2,L2):-!.
unic([H1|T1],L2,R):- memb(H1,T1,L2),!,del(H1,T1,Tr1),del(H1,L2,Lr2),unic(Tr1,Lr2,R).
unic([H1|T1],L2,[H1|R]):- unic(T1,L2,R).

:- initialization(main).
main :- unic([a,b,c,d], [b,c,d,e], L), write(L).