%% sheet_feeder(T),writeln(T).
%% T = ["a\na", "B\nb\nb", "C\nc\nc"].

sheet_feeder(T) :-
	directory_files("raw_sources/",F),
	delete_invisibles_etc(F,G),
	findall(K1,(member(H,G),		
	string_concat("raw_sources/",H,String00b),
	phrase_from_file_s(string(String001), String00b),
	%string_codes(String000,String001),
	append(String001,`\n\n`,String00_a),
	%trace,
	strip_illegal_chars(String00_a,[],String00),
		split_on_substring(String00,`\n\n`,[],J1),
		%%maplist(append,[J2],[J1]),
		%%findall(J4,(member(J3,J2),%%trace,
		%%concat_list(J3,J4)),K1),
		delete(J1,"",K2),
		K1=["Surname, A 2000, <i>Title: Subtitle</i>, Publisher, City.","Surname, A 2000",1|K2],
		term_to_atom(K1,K),
		string_concat("sources/",H,String00bb),
	(open_s(String00bb,write,Stream1),
	write(Stream1,K),
	close(Stream1))

		),T).

		%%split_on_double_newline(J,[],K)),T).

split_on_substring([],_A,E,E) :- !. %% ***?
split_on_substring(A,B,E,C) :-
	append(B,D,A),
	split_on_substring(D,B,[],C1),
	string_codes(E1,E),
	append([E1],C1,C),!.
split_on_substring(A,B,E1,C) :-
	length(E,1),
	append(E,D,A),
	append(E1,E,E2),
	split_on_substring(D,B,E2,C),!.
	
strip_illegal_chars([],A,A) :- !.
strip_illegal_chars(A,B,E) :-
	length(E1,1),
	append(E1,D,A),
	%string_codes(E11,E1),
	%char_type(E11,quote),
	E1=[92],%`\\`,
	append(B,``,F),
	strip_illegal_chars(D,F,E),!.
strip_illegal_chars(A,B,E) :-
	length(E1,2),
	append(E1,D,A),
	%string_codes(E11,E1),
	%char_type(E11,quote),
	E1=`- `,
	append(B,``,F),
	strip_illegal_chars(D,F,E),!.
strip_illegal_chars(A,B,E) :-
	length(E1,1),
	append(E1,D,A),
	%string_codes(E11,E1),
	%char_type(E11,quote),
	((E1=`"` -> true;
	(E1=[8220] -> true; % `“`
	(E1=[8221] -> true; % `”`
	(E1=[8216] -> true; % `‘`
	(E1=[8217] -> true; % `’`
	(E1=`'`))))))),
	append(B,`'`,F),
	strip_illegal_chars(D,F,E),!.
strip_illegal_chars(A,B,E) :-
	length(C,1),
	append(C,D,A),
	/**
	string_codes(C1,C),
	(char_type(C1,alnum)->true;
	(char_type(C1,white)->true;
	(char_type(C1,digit)->true;
	(char_type(C1,punct)->true;
	(char_type(C1,newline)))))),
	**/
	append(B,C,F),
	strip_illegal_chars(D,F,E),!.
/**
strip_illegal_chars(A,B,E) :-
	length(E1,1),
	append(E1,D,A),
	append(B,` `,F),
	strip_illegal_chars(D,F,E),!.
**/

strip_illegal_chars1 :-
	directory_files("raw_sources/",F),
	delete_invisibles_etc(F,G),
	findall(String00,(member(H,G),		
	string_concat("raw_sources/",H,String00b),
	phrase_from_file_s(string(String001), String00b),
	string_codes(String000,String001),
	string_concat(String000,"\n\n",String00_a),
	%%trace,
	strip_illegal_chars(String00_a,"",String00),
		%%split_on_substring(String00,"\n\n","",J1),
		%%maplist(append,[J2],[J1]),
		%%findall(J4,(member(J3,J2),%%trace,
		%%concat_list(J3,J4)),K1),
		%%delete(J1,"",K1),
		term_to_atom(String00,K),
		string_concat("sources/",H,String00bb),
	(open_s(String00bb,write,Stream1),
	write(Stream1,K),
	close(Stream1))

		),_T).
		
		%% sheet_feeder and strip_illegal_chars1 are too slow.  Use BBEdit to replace \n\n with ",\n\n", insert ["*","*",1," at start, "] at end and replace \\ with nothing