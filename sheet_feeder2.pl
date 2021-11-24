sheet_feeder2(T) :-

	directory_files("raw_sources/",F),
	delete_invisibles_etc(F,G),
	findall(K1,(
	member(H,G),	
	string_concat("raw_sources/",H,List00b),
	phrase_from_file_s(string(List001), List00b),
	
	reverse(List001,S1),(append([10],A,S1)->B=A;B=S1),reverse(B,J1),
	
	%J1=["“","”","‘","’","'","\"","\n","\\","\n","- ","\n","\n","\n","b"],

	%J1=["“","'","\n"],

	append(J1,`\n\n`,List00_a),
	process(List00_a,[],List00),

	%writeln1(List00),trace,
	delete(List00,"",K2),
	
	K1=["Surname, A 2000, <i>Title: Subtitle</i>, Publisher, City.","Surname, A 2000",1|K2],
	term_to_atom(K1,K),
	%random(X),
	%foldr(string_concat,[H,X,".txt"],H1),
	string_concat("sources/",H,List00bb),
	(open_s(List00bb,write,Stream1),
	write(Stream1,K),
	close(Stream1))

	),T).
	
process(List0,List1,List2) :-

	replace(Pairs),
	(not((append(_B11,C11,List0),append(A,_C31,C11),
	(member([A,_],Pairs)->true;A=`\n`)))->
	(string_codes(Middle1,List0),
	append(List1,[Middle1],List2));
	
	(process2(List0,[],List4,_,C32),
	string_codes(Middle1,List4),
	append(List1,[Middle1],List3),
			
	process(C32,List3,List2))),!.


process2([],List,List,B,B) :- !.
process2(List,List1,List2,B12,B13) :-
%trace,
	replace(Pairs),
	(append(B11,C11,List),append(A,C31,C11),
	%[A1]=A,
	(member([A,B],Pairs)->(foldr(append,[B],B2),
	append(List1,B2,List3),
	process2(C31,List3,List2,B12,B13));
	
	(A=`\n\n`
	->(%trace,
	%writeln1(append(List1,B11,List2)),
	B13=C31,append(List1,B11,List2));
	
	(%trace,
	not(A=[]),(A=`\n` -> (List=`\n`->true;not(append(`\n`,_,C31)));true),
	(A=`-` -> not(append(` `,_,C31));true),
	%((A=`\n\n`->true;A=`- `)->A1=``;A1=A),
	%trace,
	foldr(append,[B11,A
	],B2),
	append(List1,B2,List3),
	%notrace,
	process2(C31,List3,List2,B12,B13))
	
	))).
	
replace([[`\\`,``],[`- `,``],[`\"`,`'`],[`“`,`'`],[`”`,`'`],[`‘`,`'`],[`’`,`'`]]).


