short_essay_helper_keywords_per_paragraph(%%Filex,
	String01,Key_words1a,
	Reasons_per_paragraph,Choosing_method) :-
	
	retractall(choosing_method(_)),
	assertz(choosing_method(Choosing_method)),

	length(Key_words1a,Key_words_length),
	
	retractall(num_paras_exp(_)),
	assertz(num_paras_exp(Key_words_length)),

	retractall(num_paras_crit(_)),
	assertz(num_paras_crit(Key_words_length)),

	retractall(end_note_number(_)),
	assertz(end_note_number(1)),

	retractall(refs(_)),
	assertz(refs([])),

	%retractall(chosen_quotes(_)),
	%assertz(chosen_quotes([])),

	directory_files("sources/",F),
	delete_invisibles_etc(F,G),
%%trace,
SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",

	findall(String00z1,(member(Key_words,Key_words1a),

	findall(String02h3,(member(Filex1,G),
	string_concat("sources/",Filex1,Filex),
		phrase_from_file_s(string(String00a), Filex),
		string_codes(String02b,String00a),
		atom_to_term(String02b,String02a,[]),
		
		(String02a=[Az,Bz,Cz|String02c]->true;
		(concat_list(["Error: ",Filex," not in format [\"Surname, A 2000, <i>Title: Subtitle</i>, Publisher, City.\",\"Surname, A 2000\",First_Page_Num,\"<first page>\",\"<second page>\",...\"]"],Notification1),writeln(Notification1),abort)),
		%%String02c=String02d,
		%%trace,
		findall([Az,Bz,Cz,N1,String02cb],(
		
	length(String02c,L),
	numbers(L,1,[],N),
	%%random_
	member(N1,N),
	get_item_n(String02c,N1,String02ca),

		%%member(String02ca,String02c),
		split_string(String02ca, ".\n\r", ".\n\r", String02cb)
		
		%%member(String02cb1,String02cb)
		
		),String02cc),
		%%maplist(append,[String02cc],[String02d]),
		
		%%delete(String02cc,[_,[]],String02d),
		String02cc=String02d,
		
		findall([Az,Bz,Cz,N2,String02d2],(member([Az,Bz,Cz,N2,String02d1],String02d),
		member(String02d2,String02d1),
		downcase_atom(String02d2,String02e),
		atom_string(String02e,String02f1),
		split_string(String02f1, SepandPad, SepandPad, String02e1),
		findall(String02g,(member(Key_words1,Key_words),
			%%trace,
		downcase_atom(Key_words1,Key_words11),
		atom_string(Key_words11,Key_words12),
findall(Key_words12,(member(Key_words12,String02e1)),String02g)
		),String02i),
		not(maplist(equals_empty_list,String02i))

			),String02h31),
			
			sort(String02h31,String02h3)

		%%prepare_file_for_ml(String00,String02a)
		),String00z1)),
		String0001),
		
findall([Exposition,Critique],(member(String00z1,String0001),
	
	retractall(string00_z(_)),
	%%assertz(string00_z([])),

	retractall(critique3(_)),
	assertz(critique3([])),

		maplist(append,[String00z1],[String00]),%%)
		%%),String00z),

%%delete(String00z,[],String00),


term_to_atom(Key_words,Key_words_a),
atom_string(Key_words_a,Key_words_b),		
		(String00=[]->(concat_list(["Error: No files in source folder or no instances of keywords ",Key_words_b," in files in source folder."],Notification2),writeln(Notification2),abort);true),

				%%maplist(append,[[String00z1]],String00),
%%maplist(append,[String00z],String00),
		%%trace,
assertz(string00_z(String00)),
		%%writeln1([string00,String00]),
		%%notrace,
	
%%writeln1(String02),



	Numbers=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],
	explain_structure(String01,Reasons_per_paragraph,File1),
	exposition(String00,String01,Reasons_per_paragraph,Numbers,String02,Exposition),

	%%concat_list(["Do you agree or disagree with ",String01," (a/d) ? "],String2ad),%%get_string(String2ad,either,one-not-ml,"","",String3ad),
	choose1(["a"%%,"d"
	],String3ad),
	
	(String3ad="a"->
	(retractall(agree_disagree(_)),
	assertz(agree_disagree(agree)));
	(retractall(agree_disagree(_)),
	assertz(agree_disagree(disagree)))),


critique(String00,String01,Reasons_per_paragraph,Numbers,String02,Critique)

),Exposition_critique),

	generate_file_name(File1,File2),

findall(Exposition,(member([Exposition,_],Exposition_critique)),Exposition1),
findall(Critique,(member([_,Critique],Exposition_critique)),Critique1),
%findall(Exposition2,(member([Exposition2|_],Exposition1)),Exposition2a),


agree_disagree(Pole),

	%%concat_list(["What is the future area of research from your essay about ",String01,"? "],Future_research_prompt),
	%%trace,
	%%get_string(Future_research_prompt,either,one-not-ml,"","",Future_research),
%%	choose_sentence_range(String00,),
	choose(N_page_ref,String00a1,String00a2,_String00a3,_String00a4,String00a5),
	concat_list(["In ",String01,", automation should apply to \"",String00a5,"\" (",String00a2,", p. ",N_page_ref,")."],Future_research),
	%reference(String00a1),
	%trace,
term_to_atom([Exposition1,Critique1,Future_research],File_contents),open_s(File1,write,Stream),write(Stream,File_contents),close(Stream),

%% Output essay
%%findall(_,(member(Exposition1,Exposition),Exposition1=

refs(R2),

%%writeln1([Exposition,Critique,Future_research,R2]),

write_essay1(String01,Pole,Exposition1,Critique1,Future_research,R2,Essay,HTML),


%%%%%%%

	
	%%%%%
writeln1(Essay),

	(open_s(File2,write,Stream1),
%%	string_codes(BrDict3),
	write(Stream1,HTML),
	close(Stream1)),!
	.

write_essay1(String01,Pole,Exposition1,Critique1,Future_research,R2,"",HTML) :-
	write_heading(String01,_Heading),
	%trace,
	write_introduction1(String01,Pole,Critique1,Introduction),
	findall(Exposition2a1,(member(Exposition,Exposition1),
	write_exposition(Exposition,Exposition2a1)),Exposition2a2),
	flatten(Exposition2a2,Exposition2a3),
	concat_list(Exposition2a3,Exposition2a),
	concat_list(["I will expose ",String01," in this half.  ",Exposition2a],Exposition2),
	%%string_concat(Exposition2,"\n",Exposition2a),
	%trace,
	findall(Critique2a1,(member(Critique,Critique1),
	write_critique(Critique,Critique2a1)),Critique2a2),
	flatten(Critique2a2,Critique2a3),
	concat_list(Critique2a3,Critique2a),
	string_concat(Critique2a,"\n",Critique2b),
	atom_string(Pole,Pole1),
	concat_list(["I will ",Pole1," with ",String01," in this half.  ",Critique2b],Critique2),
	write_conclusion1(String01,Pole,Critique1,Future_research,Conclusion),
	write_end_notes(R2,_End_notes,End_notes_no_heading),
	write_references(R2,_References,Refs_no_heading),
	%%concat_list([Heading,Introduction,Exposition2,Critique2,Conclusion,End_notes,References],
	%%Essay),
	strip_footnotes(Introduction,Introduction_1),
	strip_footnotes(Conclusion,Conclusion_1),
	concat_list([Introduction_1,Exposition2,Critique2,Conclusion_1],
	Essay2),
	%%trace,
	reorder_numbers(Essay2,Essay21,End_notes_no_heading,End_notes_no_heading1),
	replace(Essay21,"\n","<br>",HTML1),
	replace(Refs_no_heading,"\n","<br>",Refs_no_heading2),
	replace(End_notes_no_heading1,"\n","<br>",End_notes_no_heading2),
	concat_list(["<html><head><title>",String01,"</title></head><body><h1>",
	String01,"</h1>",HTML1,"<h2>Endnotes</h2>",End_notes_no_heading2,"<h2>Bibliography</h2>",Refs_no_heading2,"</body></html>"],HTML).
	
write_introduction1(String01,Pole1,Critique,Introduction) :-
	%% The heading should be in the form "Author's topic"
	atom_string(Pole1,Pole2),
	findall([Paragraph_topic_sentence,"  "],(member(B,Critique),member(A,B),A=[_,[Paragraph_topic_sentence|_]|_]),Paragraph_topic_sentences1),
	concat_list1(Paragraph_topic_sentences1,Paragraph_topic_sentences2),
	concat_list(["I will critically analyse ",String01,".  ",
	"I will ",Pole2," with ",String01,".  ",
	Paragraph_topic_sentences2,"\n\n"],Introduction).

write_conclusion1(String01,Pole1,Critique,Future_research,Conclusion) :-
	atom_string(Pole1,Pole2),
	findall([Paragraph_topic_sentence,"  "],(member(B,Critique),member(A,B),A=[_,[Paragraph_topic_sentence|_]|_]),Paragraph_topic_sentences1),
	concat_list1(Paragraph_topic_sentences1,Paragraph_topic_sentences2),
	concat_list([
	Paragraph_topic_sentences2,
	"I have ",Pole2,"d with ",String01,".  ",
	Future_research,"\n\n"
	],Conclusion).