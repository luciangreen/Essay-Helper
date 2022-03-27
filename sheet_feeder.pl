sheet_feeder(T) :-

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
	
process(A,_,C) :-
 replace(Replacements),
 atom_string(A1,A),
 replace1(Replacements,A1,D1),
 atomic_list_concat(D,'\n\n',D1),
 findall(C1,(member(D2,D),atom_string(D2,C1)),C),!.

replace1([],A,A) :- !.
replace1(Replacements,A,D) :-
 Replacements=[[B,C]|G],
 atomic_list_concat(E,B,A),
 atomic_list_concat(E,C,F),
 replace1(G,F,D),!.

	replace([['\\',''],['- ',''],['"','\''],['“','\''],['”','\''],['‘','\''],['’','\'']]).
