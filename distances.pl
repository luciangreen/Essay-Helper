/**

	yes, no for true, false cawps data
	- keeps increasing k until yes
	- don't need yes or no, need predicate
	can select predicates in cawps using distances.pl
	- finds predicates from similar i/o *
	- breaks down data and then *
	- code db needs i,o
		- convert code to pl
		- find child predicates
		- print with i,o
		- eliminate dups
	
		- split predicates into smaller predicates ()
		- may find approximate predicates (with arguments out of order) that can be corrected with cawps argument re-ordering
		- cut off with first item in list in case multiple items causes a malfunction in algorithm
		- find i not o, then chains of i,o until alg completed
		- " for vertical chains (find o, then i,o inside recursive structs)

	- use types not atoms - ? - use atoms
	
	* spec finder combines parts of specs, generating content within different types
	- finds algorithm, spec part by spec part
	- e.g. alg to modify alg takes first alg, changes, then modified alg
	- finds alg before finding whole spec, finds data before all data (bottom up)
	- uses only what data's changed or needed
	- combines two sentence specs into one
	
	* alg finder is part of spec finder, can do separately
	
	- do i,o passes of distances separately x together, don't need y, n

	1. modify cawps
	2. prepare data

**/

%% distances.pl - from Luc De Raedt

:-use_module(library(clpfd)).

o_o_dis(X,X,D):-D #= 0,!.
o_o_dis(X,Y,D):-
    atomic(X),
    atomic(Y),
    o_o_constantDis(X,Y,D),!.
o_o_dis(X,Y,D):-
    X =..[XF|XRest],
    length(XRest,XN),
    Y =.. [YF|YRest],
    length(YRest,YN),
    dif(XF,YF),
    o_o_functorDis(XF-XN,YF-YN,D),!.
o_o_dis(X,Y,D):-
    X =..[XF|XRest],
    length(XRest,XN),
    Y =.. [YF|YRest],
    length(YRest,YN),
    dif(XN,YN),
    o_o_functorDis(XF-XN,YF-YN,D),!.

o_o_dis(X,Y,D):-
    X=..[F|XRest],
    Y=..[F|YRest],
    length(XRest,N),
    length(YRest,N),
    maplist(o_o_dis,XRest,YRest,Distances),
    sumlist(Distances,D0),
    o_o_functorDis(F-N,F-N,D1),
    D #= D1 +D0,!.

o_o_dis(_X,_Y,D):-
       D #= 0.

o_o_constantDis(X,Y,D):-
    dif(X,Y),
    D #= 1.
o_o_constantDis(X,X,D):-
    D #= 0.

o_o_functorDis(X,Y,D):-
    dif(X,Y),
    D #= 1.
o_o_functorDis(X,X,D):-
    D #= 0.

topk_vote(T,Vote):-
    pairs_values(T,V),
    msort(V,VSorted),
    length(T,L),
    L2 #= L div 2,
    length(First,L2),
    append(First,[Vote|_Rest],VSorted).

o_oclass_disClass(O,O2,D-O2):-
   o_o_dis(O,O2,D).

key_value_keyvalue(Key,Value,Key-Value).

data_instance_k_classification(Data,I,K,C):-
    maplist(o_oclass_disClass(I),Data,DisAndClass),
    keysort(DisAndClass,DSorted),
    
    writeln(DSorted),
    
    length(TopK,K),
    append(TopK,_,DSorted),
    topk_vote(TopK,C).



data(X):-
    X=[

[2,1,["i","prepared","to","neaten","my","desk"]]
,[2,2,["i","did","this","by","providing","management","service","as","breasonings","currency"]]
,[2,3,["first","i","deciphered","it"]],[2,4,["second","i","held","it"]],[2,5,["third","i","managed","it"]],[2,6,["in","this","way","i","prepared","to","neaten","my","desk","by","providing","management","service","as","breasonings","currency"]]

      ].


%% need to paraphrase by replacing one word, optionally adding words to the end, or deleting words.
%% not k=1 or 2, just not k=0 and first one
%% it doesn't matter if the paraphrase is strong, as long as the right sentence is returned
%% check all sentences in step 1, 2 in step 2
test(Test):-
    Test =
["i","neatened","my","desk"]
          
                         .

/** <examples>
 ?-data(X),test(T),data_instance_k_classification(X,T,3,C).
 */
