
:-include('../Philosophy/word_frequency_count.pl').
:-include('../listprologinterpreter/la_files.pl').

% auto_essay_helper("Title",1,member).

auto_essay_helper(Title,Reasons_per_paragraph,Selection_method) :-
	%sheet_feeder(_),
	open_file_s("../Philosophy/connectives.txt",Connectives),
	directory_files('sources/',F),
	delete_invisibles_etc(F,G),
	findall(Freq,	(member(H,G),
	string_concat("sources/",H,H1),
	open_file_s(H1,[_,_,_,_|J]),
	term_to_atom(J,K),string_atom(K,K1),
	word_frequency_count(["string",K1],Freq)),Freqs0),
	foldl(append,Freqs0,[],Freqs),
	%foldl(intersection,Freqs,[],Freqs1),
	sort(Freqs,Freqs1),
	%findall(L,member([_,L],Freqs1),M),
	findall([O,P],(member([O,P],Freqs1),not(member(P,Connectives))),%,
	%subtract(Freqs1,Connectives,
	Freqs2),
	sort(Freqs2,Freqs3),
	findall([Freqs4],member([_,Freqs4],Freqs3),Freqs5),
	writeln1(Freqs5),
	writeln("Please enter keywords for each paragraph in form [[\"para1kw1\",\"para1kw2\"],[\"para2kw1\",\"para2kw2\"], ...] :"),
	read_string(user_input, "\n", "\r", _, KW1),
	%(Freqs3=[[_,Q],[_,R],[_,S],[_,T],[_,U]|_]),%->true;
	%(writeln("Not enough keywords in sources.",abort))),
	term_to_atom(KW,KW1),
		short_essay_helper_keywords_per_paragraph(Title,KW,Reasons_per_paragraph,Selection_method),!.
	
