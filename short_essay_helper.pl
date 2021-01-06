%% Prolog Short Essay Helper

%% Keep 1,2,3 in aphors
%% Certain number of reasons per paragraph
%% Explains essay structure at start
%% Exposition (negative terms not allowed, asks for 5 groups from text to take optionally enough notes about, which can revise) and critique
%% Paraphrasing
%% Converts x, explains x, asks about
%% Allows citation of aphor
%% Prints citations used so far
%% Prints chapter, essay and allows changes (using text editor) at end.
%% Outputs db file and br dicts for marking later

%% *** Rewrite essay files with e.g. 1a. before aphors not 1. so not confused with aphors

%% short_essay_helper("file.txt",5,E),writeln1(E).

:- include('distances.pl').
:- use_module(library(date)).
:- include('../listprologinterpreter/la_strings').

:- dynamic critique3/1.
:- dynamic agree_disagree/1.

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

short_essay_helper(Filex,Reasons_per_paragraph) :-
	retractall(critique3(_)),
	assertz(critique3([])),

	phrase_from_file_s(string(String00), Filex),

	split_string(String00, "\n\r", "\n\r", [String01|_]),

	prepare_file_for_ml(String00,String02),
	
writeln1(String02),

	generate_file_name(String01,File1),

	Numbers=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],
	explain_structure(String01,Reasons_per_paragraph,File1),
	exposition(String00,String01,Reasons_per_paragraph,Numbers,String02,Exposition),

	concat_list(["Do you agree or disagree with \"",String01,"\" (a/d) ? "],String2ad),get_string(String2ad,either,one-not-ml,"","",String3ad),
	
	(String3ad="a"->
	(retractall(agree_disagree(_)),
	assertz(agree_disagree(agree)));
	(retractall(agree_disagree(_)),
	assertz(agree_disagree(disagree)))),


critique(String00,String01,Reasons_per_paragraph,Numbers,String02,Critique),

agree_disagree(Pole),

	concat_list(["What is the future area of research from your essay about \"",String01,"\"? "],Future_research_prompt),
	%%trace,
	get_string(Future_research_prompt,Pole,one-not-ml,"","",Future_research),
	
term_to_atom([Exposition,Critique,String3ad,Future_research],File_contents),open_s(File1,write,Stream),write(Stream,File_contents),close(Stream).

	
	
	/**critique(String00,String01,Reasons_per_paragraph,Numbers,Critique).
	**/
	
generate_file_name(String01,File1) :-
			get_time(TS),stamp_date_time(TS,date(Year,Month,Day,Hour1,Minute1,Seconda,_A,_TZ,_False),local),
	concat_list([String01," file",Year,Month,Day,Hour1,Minute1,Seconda,".txt"],File1).

explain_structure(String01,Reasons_per_paragraph,File1) :-
	concat_list(["The Short Essay Helper will you help structure and write your essay about \"",String01,"\" with ",Reasons_per_paragraph," reasons per paragraph.","\n",
	"The Helper will help write an exposition (which summarises but doesn't critique the idea), a critique (which agrees with or disagrees with the topic), the introduction and the conclusion (which state whether you agreed or disagreed with the topic, etc.).","\n","The Helper will output the file, \"",File1,"\" used for marking.  After using the Helper, run Text To Breasonings.  Return \"",File1,"\" and the two breasoning dictionaries for marking."],String1),
	writeln(String1).

exposition(String00,String01,Reasons_per_paragraph,Numbers,ML_db,Exposition1) :-
	length(List1,5),
	append(List1,_,Numbers),
	length(List2,Reasons_per_paragraph),
	append(List2,_,Numbers),

	string_codes(String001,String00),
	writeln(String001),
	findall([Number1,Exposition2],(
		%%trace,
member(Number1,List1),concat_list(["What is group ",Number1," of 5 in the exposition that groups ideas about \"",String01,"\"? "],String1),get_string(String1,positive,one-not-ml,"","",%ML_db,
Exposition2)),Exposition3),

	findall([Number2,Number3,String3,String3a,String5a,String5],(
	member(Number2,List1),member(Number3,List2),get_item_n(Exposition3,Number2,[_,Item1]),
	%%trace,
	concat_list(["<Exposition Paragraph ",Number2," of 5 - \"",Item1,"\"> <Reason ",Number3," of ",Reasons_per_paragraph,">","\n","The Helper will ask you how the quote you are about to enter relates to the paragraph topic."],String2b),writeln(String2b),
	%%trace,
exposition2(Item1,ML_db,String3,String3a,String5a,String5)
	),Exposition4),
	Exposition1=[Exposition3,Exposition4].
	
exposition2(Item1,ML_db,String3,String3a,String5a,String5):-
	(concat_list(["What is the paragraph number of the quote about the paragraph topic \"",Item1,"\"? "],String2),get_number(String2,String3),
	concat_list(["What is the sentence number of the quote about the paragraph topic \"",Item1,"\"? "],String2a),get_number(String2a,String3a),
	member1a([String3,String3a,String3aa],ML_db),
	concat_list(["What is the paraphrased quote about the paragraph topic \"",Item1,"\"? "],String4a),get_string(String4a,positive,one,"",String3aa,String5a),
	concat_list(["How does the quote you entered (\"",String5a,"\") relate to the paragraph topic \"",Item1,"\"? "],String4),
	%%trace,
	SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",downcase_atom(Item1,String41a),split_string(String41a, SepandPad, SepandPad, Item1a),
	
	get_string(String4,positive,two,Item1a,String3aa,String5))
	->true;exposition2(Item1,ML_db,String3,String3a,String5a,String5).

%% Agree or disagree

critique(String00,String01,Reasons_per_paragraph,Numbers,ML_db,Critique1) :-
	length(List1,5),
	append(List1,_,Numbers),
	length(List2,Reasons_per_paragraph),
	append(List2,_,Numbers),

	string_codes(String001,String00),
	writeln(String001),

	retractall(critique3(_)),
	assertz(critique3([])),


	findall([Number2a,Critique2],(
%% Reason 1

member(Number2a,List1),
%%List1=[Number2a|List1a],
List2=[Number3a|List2a],
%%trace,


critique_reason1(String01,Number2a,Number3a,Reasons_per_paragraph,ML_db,Critique3,Topic_paragraph_link),

critique_reasons_2_to_n(Number2a,List2a,Critique3,Reasons_per_paragraph,ML_db,Critique4),

	append_list2([[Topic_paragraph_link],Critique3,Critique4],Critique2)),Critique1).
	
	critique_reason1(String01,Number2a,Number3a,Reasons_per_paragraph,ML_db,Critique3,Topic_paragraph_link) :-

	%%member(Number2,List1),member(Number3,List2),
	%%get_item_n(Critique3,Number2a,[_,Item1]),
	%%trace,
	concat_list(["<Critique Paragraph ",Number2a," of 5> <Reason ",Number3a," of ",Reasons_per_paragraph,">","\n","The Helper will ask you for your comment on the quote you are about to enter."],String2b),writeln(String2b), 
	%% Later: connections

	%%trace,
critique2(String01,ML_db,String3,String3a,String5a,String3y,String3ay,String5a1,Topic_paragraph_link),
	%%),Critique4).
	Critique3=[[Number2a,Number3a,String3,String3a,String5a,String3y,String3ay,String5a1]].
	
critique2(String01,ML_db,String3,String3a,String5a,String3y,String3ay,String5a1,Topic_paragraph_link):-
	(concat_list(["What is the paragraph number of the quote to comment on? "],String2),get_number(String2,String3),
	concat_list(["What is the sentence number of the quote to comment on? "],String2a),get_number(String2a,String3a),
	member1a([String3,String3a,String3aa],ML_db),
	concat_list(["What is the paraphrased quote to comment on? "],String4a),get_string(String4a,positive,one,"",String3aa,String5a),
	
	concat_list(["Is your comment from a quote (y/n)? "],String2yn),get_string(String2yn,either,one-not-ml,"","",String3yn),
	
	agree_disagree(Pole),

	(String3yn="y"->
	(concat_list(["What is the paragraph number of the comment? "],String2y),get_number(String2y,String3y),
	concat_list(["What is the sentence number of the comment? "],String2ay),get_number(String2ay,String3ay),
	%%trace,
	member1a([String3y,String3ay,String3aay],ML_db),
	
	%% use either original x or paraphrase
	
	concat_list(["What is the comment that is from the quote? "],String4ac),
	%%trace,
	get_string(String4ac,Pole,one,"",String3aay,String5a1)
		)
		
	;(String3y=0,String3ay=0,
	concat_list(["What is the comment? "],String4ac),get_string(String4ac,Pole,one-not-ml,"","",%%String5a,
	String5a1))),
	
	concat_list(["How does the comment \"",String5a1,"\" relate to the essay topic \"",String01,"\"? "],Topic_paragraph_link_prompt),
	%%trace,
	
	downcase_and_split(String5a1,String5a1ds),
	downcase_and_split(String01,String01ds),
	get_string(Topic_paragraph_link_prompt,positive,two,String5a1ds,String01ds,Topic_paragraph_link)
	

	/**
	%% conn - choose connected comments
	concat_list(["How does the quote you entered (\"",String5a,"\") relate to the paragraph topic \"",Item1,"\"? "],String4),
	%%trace,
	SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",downcase_atom(Item1,String41a),split_string(String41a, SepandPad, SepandPad, Item1a),
	
	get_string(String4,either,two,Item1a,String3aa,String5)
	**/
	)
	->true;critique2(String01,ML_db,String3,String3a,String5a,String3y,String3ay,String5a1,Topic_paragraph_link).



critique_reasons_2_to_n(Number2a,List2a,Critique3,Reasons_per_paragraph,ML_db,Critique4) :-
	retractall(critique3(_)),
	assertz(critique3(Critique3)),
%%trace,
/**	critique3(Critique31),
	append(Critique31,Critique3,Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32)),
**/
%%notrace,
findall([Number2a,Number3a,String3,String3a,String5a,String3y,String3ay,String5a1,
CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa],(
	%%member(Number2,List1a),
	member(Number3a,List2a),
	%%get_item_n(Critique3,Number2a,[_,Item1]),
	%%trace,
	concat_list(["<Critique Paragraph ",Number2a," of 5> <Reason ",Number3a," of ",Reasons_per_paragraph,">","\n","The Helper will ask you for your comment on the quote you are about to enter."],String2b),writeln(String2b), 
	%% Later: connections

	
	%%trace,
critique3(ML_db,%%Critique3,
String3,String3a,String5a,String3y,String3ay,String5a1,
CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa)
	

/**
	trace,
	critique3(Critique31),
	append(Critique31,[[String3,String3a,String5a,String3y,String3ay,String5a1]],Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32))
**/

),
	Critique4).
	
	%%Critique3=[].
	
critique3(ML_db,%%Critique3,
String3,String3a,String5a,String3y,String3ay,String5a1,
CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa):-
	(concat_list(["What is the paragraph number of the quote to comment on? "],String2),get_number(String2,String3),
	concat_list(["What is the sentence number of the quote to comment on? "],String2a),get_number(String2a,String3a),
	member1a([String3,String3a,String3aa],ML_db),
	concat_list(["What is the paraphrased quote to comment on? "],String4a),get_string(String4a,positive,one,"",String3aa,String5a),
	
	concat_list(["Is your comment from a quote (y/n)? "],String2yn),get_string(String2yn,either,one-not-ml,"","",String3yn),
	
	agree_disagree(Pole),

	(String3yn="y"->
	(concat_list(["What is the paragraph number of the comment? "],String2y),get_number(String2y,String3y),
	concat_list(["What is the sentence number of the comment? "],String2ay),get_number(String2ay,String3ay),
	%%trace,
	member1a([String3y,String3ay,String3aay],ML_db),
	
	%% use either original x or paraphrase x
	%%trace,
	concat_list(["What is the comment that is from the quote? "],String4ac),
	%%trace,
	get_string(String4ac,Pole,one,"",String3aay,String5a1)
	%%,trace
		)
		
	;(String3y=0,String3ay=0,
	concat_list(["What is the comment? "],String4ac),get_string(String4ac,Pole,one-not-ml,"","",%%String5a,
	String5a1))),
	%%*** assertz recurse not findall new critique3 x


	%%trace,
	critique3(Critique31),
	append(Critique31,[[0,0,String3,String3a,String5a,String3y,String3ay,String5a1]],Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32)),

	critique3(Critique33),


((


	%%critique3(Critique3),
	length(Critique33,LCritique3),
	%%length(List1,LCritique3),
	numbers(LCritique3,1,[],List1),
	%%append(List1,_,Numbers),
	%%Numbers=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],
	%%trace,

findall([N," - ",CString5a1,"\n"],(member(N,List1),get_item_n(Critique33,N,[CNumber2a,CNumber3a,_CString3,_CString3a,_CString5a,_CString3y,_CString3ay,CString5a1])),CStrings1),

findall([N,CNumber2a,CNumber3a,CString5a1],(member(N,List1),get_item_n(Critique33,N,[CNumber2a,CNumber3a,_CString31,_CString3a1,_CString5a1,_CString3y1,_CString3ay1,CString5a1])),CStrings2),

%%trace,

%%CStrings=[CStrings1,CStrings2],
reverse(CStrings2,CStringsR),CStringsR=[[_,CNumber2a1,CNumber3a1,LastCStrings]|CStringsR1],
reverse(CStringsR1,CStringsRR),

reverse(CStrings1,CStringsR10),CStringsR10=[_|CStringsR11],
reverse(CStringsR11,CStringsRR1),

append_list2(CStringsRR1,CStrings11),
concat_list(CStrings11,CStrings12),
concat_list(["Please select a comment to connect the comment \"",LastCStrings,"\" to:","\n",CStrings12],ConnectionNumberPrompt),
get_number(ConnectionNumberPrompt,ConnectionNumber),

	member([ConnectionNumber,CNumber2aa,CNumber3aa,CString5a1a],CStringsRR),
	
		SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",downcase_atom(CString5a1a,CString5a1a1),split_string(CString5a1a1, SepandPad, SepandPad, CString5a1a2),
		
		%%CNumber2a1,CNumber3a1,
		downcase_atom(LastCStrings,LastCStrings_a),split_string(LastCStrings_a, SepandPad, SepandPad, LastCStrings_a1),
		

	%% conn - choose connected comments, this to a previous comment
	%%trace,
	
	concat_list(["How does \"",LastCStrings,"\" connect to \"",CString5a1a,"\"? "],ConnectionPrompt),

	get_string(ConnectionPrompt,Pole,two,CString5a1a2,LastCStrings_a1,String5aaa))->true;(
	
	%% If the section since updating dynamic critique comments fails, prevent doubling of critique comments
	
		critique3(Critique311),
		reverse(Critique311,Critique312),
		Critique312=[_|Critique313],
		reverse(Critique313,Critique314),
	retractall(critique3(_)),
	assertz(critique3(Critique314)),fail

	))
	
/**		Critique4=[String3,String3a,String5a,String3y,String3ay,String5a1,
	CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa],
	**/
	/**
	critique3(Critique31),
	append(Critique31,[[String3,String3a,String5a,String3y,String3ay,String5a1]],Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32))
**/

	)
	%% Retries the predicate if it fails
	->true;critique3(ML_db,%%Critique3,
	String3,String3a,String5a,String3y,String3ay,String5a1,
	CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa
	).
	
	
	
	
member1a([String3,String3a,String3aa],ML_db) :-
	member([String3,String3a,String3aa],ML_db),!.

	
get_item_n(Exposition,Number1,Item) :-
	Number2 is Number1-1,
	length(List,Number2),
	append(List,[Item|_],Exposition).

get_number(Prompt1,Number) :-
	%%concat_list(Prompt1,Prompt2),
	(%%repeat,
	writeln(Prompt1),read_string(user_input, "\n", "\r", _End, String),split_string(String, ",", " ", Value1),Value1=[Value2],number_string(Number,Value2)).
	
	
/**
get_string(Prompt1,String1) :-
	concat_list(Prompt1,Prompt2),
	(repeat,write(Prompt2),read_string(String1),not(String1="")).
**/	

equals_empty_list([]).

downcase_and_split(String1,	String2) :-
SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	downcase_atom(String1,String3),split_string(String3, SepandPad, SepandPad, String2).

get_string(Prompt2,Flag1,Flag2,ML_db0,ML_db1,String2) :-
%%writeln1(get_string(Prompt2,Flag1,Flag2,ML_db1,String2)),
	%%concat_list(Prompt1,Prompt2),
		%%trace,
		SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	%%(repeat,
	writeln(Prompt2),read_string(user_input, "\n", "\r", _End, String2),not(String2=""),downcase_atom(String2,String3),split_string(String3, SepandPad, SepandPad, String4),
	Neg_term_list=["no","not","don","t","shouldn","wouldn","disagree","differ","dislikes","disagrees","differs","dislikes","disagreed","differed","disliked","negative","negation","non","negate","negates","negated","but","however","isn","lack"],
	(Flag1=%%non_negative
	positive->(
	
	(findall(Item11,(
	
	member(Item1,String4),
		findall(Item1,(
member(Item2,Neg_term_list),(Item1=Item2->(write("Error: Contains the negative term \""),write(Item1),writeln("\".")))),Item11)),Item12)),

maplist(equals_empty_list,Item12)

);
	((Flag1=negative->((member(Item1,String4),member(Item1,Neg_term_list))->true;(writeln("Error: Contains no negative term, one of:"),writeln(Neg_term_list),fail));true)->true;Flag1=either)),
	(Flag2=one-not-ml->true;
	(Flag2=one->(%%split_string(String4,SepandPad,SepandPad,String21),
	writeln("Attempt 1"),
	
	(length(String4,Length_string1),
(check_strings_container1(Length_string1,String4,[0,0,ML_db1],[[0,0,[xxx,xxx,xxx,xxx,xxx]],[0,0,ML_db1],[999,999,[]]],_,_List2)->
		writeln("Success");(writeln("Failed"),fail))
	%%(%%data_instance_k_classification1([[0,0,[xxx,xxx,xxx,xxx,xxx]],[0,0,ML_db1]%%,[999,999,[]]
	%%],[0,0,String4]%%21
	%%,1,String4a%%21
	%%),
	%%String4=String4a)
	%%)->
		%%(%%String4a=[_,_,String4a1],
		%%writeln([found,String4a,String4]),
%%writeln("Success"));
	%%(writeln("Failed"),fail)
	%%
	));
	(Flag2=%%[
	two,%%,P1,S1,P2,S2],
	%%trace,
	append([ML_db0],[ML_db1],ML_db2),
	check_strings(String4,ML_db2%%,P1,S1,P2,S2
	)))).
	
	
prepare_file_for_ml(String000,String021) :-
	string_codes(String001,String000),
	downcase_atom(String001,String00),
	split_string(String00, "\n\r", "\n\r", String01),
	delete(String01,"",String02),
	findall(String03,(member(String02a,String02),split_string(String02a,".",".",String04),
		((String04=[String05|String06],
		number_string(Number05,String05),
		number_sentences(Number05,1,String06,[],String03))->true;
		(findall(String08,
					(SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
			member(String04a,String04),split_string(String04a,SepandPad,SepandPad,String09),
			append_list([[""],"",String09],String08)),String03)))),String0211),
		append_list2(String0211,String021).
			
number_sentences(_,_,[],String,String) :- !.						number_sentences(Number_a,Number_b1,String06,String07,String08) :-
	String06=[String00|String12],

SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
		split_string(String00,SepandPad,SepandPad,String09),
		append_list([[Number_a],Number_b1,String09],String10),
		append(String07,[String10],String11),
		Number_b2 is Number_b1 + 1,
		number_sentences(Number_a,Number_b2,String12,String11,String08).
			

data_instance_k_classification1(Data,I,K,C):-
    maplist(o_oclass_disClass1(I),Data,DisAndClass),
    keysort(DisAndClass,DSorted),
    
    %%writeln(DSorted),
    
    length(TopK,K),
    append(TopK,_,DSorted),
    %This is not a very good way of selecting k as you may have many values with the same distance, and the sorting just cuts these off
    %Dsorted = [1-pos,3-pos,3-pos,3-neg,3-neg]
    %Topk =[1-pos,3-pos,3-pos]
    topk_vote(TopK,C).

o_oclass_disClass1(O,[A,B,O2],D-[A,B,O2]):-
   o_o_dis(O,O2,D).

%% could be in either order
%% a([w,z,a,b,e,c,z,y],[1,1,[c]],[1,2,[a]]).

%% true
%% a([a,c,b],[1,1,[a,d]],[1,2,[b]]).
%% a([a,c,b],[1,1,[a,c]],[1,2,[b]]).
%% a([a,b],[1,1,[a]],[1,2,[b]]).

%% false
%% a([c,d],[1,1,[a]],[1,2,[b]]).
 
%% q in "q a b" sends food like e in "c d e"

/**

[debug]  ?- a([q,e,r,a,t,y,u,q,e,r,a,t,y,u,c,b,x,v,n,m],[1,1,[c,a,t,y,u]],[1,2,[c,a,t,y,u]]).    [[1,1,[c,a,t,y,u]],[r,a,t,y,u]]
[[1,2,[c,a,t,y,u]],[r,a,t,y,u]]
true.

X:
[debug]  ?- a([q,e,r,a,t,y,u,c,b,x,v,n],[1,1,[c,a,t,y,u]],[1,2,[b,x,u]]).
[[1,1,[c,a,t,y,u]],[r,a,t,y,u]]
[[1,2,[b,x,u]],[c,b,x]]
true.

[debug]  ?- a([q,e,r,a,t,y,u,c,c,c,b,x,v,n],[1,1,[c,a,t,y,u]],[1,2,[b,x,v]]).                   [[1,1,[c,a,t,y,u]],[r,a,t,y,u]]
[[1,2,[b,x,v]],[c,c,c]]
true.

**/

check_strings(String1,ML_db) :-
	%%member([P1,S1,String2],ML_db),
	%%member([P2,S2,String3],ML_db),
	ML_db=[String2a,String3a],
%%writeln(["String1,String2a,String3a",String1,String2a,String3a]),
	String2=[0,0,String2a],
	String3=[0,0,String3a],
%%a(String1,String2,String3):-
	length(String1,Length_string1),
((writeln("Attempt 1"),
check_strings_container1(Length_string1,String1,String2,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String2,[999,999,[]]],_,List2),
	length(List2,Length_list2),
	%%Length_list3 is Length_list2+1,
	%%writeln(here),
	check_strings_container1(Length_list2,List2,String3,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String3,[999,999,[]]],_,_List3),
	writeln("Success")
	%%,trace
	)->true;
	(writeln("Failed"),
	writeln("Attempt 2"),
	((check_strings_container1(Length_string1,String1,String3,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String3,[999,999,[]]],_,List2),
	length(List2,Length_list2),
	%%Length_list3 is Length_list2+1,
	%%writeln(here),

	check_strings_container1(Length_list2,List2,String2,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String2,[999,999,[]]],_,_List3))->
		writeln("Success");(writeln("Failed"),fail)))
).

check_strings_container1(Length_string1,String1,String2,Db,List2,List2b) :-
check_strings1(Length_string1,String1,String2,Db,List2,List2b),not(var(List2b)).
%%check_strings_container2(Length_string1,Length_string3,List1,String2,Db,List2,List2b) :-
%%check_strings2(Length_string1,Length_string3,List1,String2,Db,List2,List2b),not(var(List2b)).


	%% finds the length of each string - from position 1 to (length of string1) of string1
	%% starts with the shortest possible string, then increases the length
	%% repeat this for second string
	%%string1
	
	%%*** check with s2,s3 in db
check_strings1(0,_String1,_String2,_Db,List2,List2) :- !.
check_strings1(Length_string1,String1,String2,Db,List2,List2b) :-
	%% finds the first str
	%%length(List,Index),
	length(List1,Length_string1),
	append(_,List1,String1),
	Length_string2 is Length_string1-1,
	Length_string3 is Length_string1+1,
	check_strings2(0,Length_string3,List1,String2,Db,List2,List2c),
	(var(List2c)->
	check_strings1(Length_string2,String1,String2,Db,List2c,List2b);List2c=List2b),!.

check_strings2(Length_string,Length_string,_String1,_String2,_Db,List2,List2) :- !.
check_strings2(Length_string1,Length_string3,List1,String2,Db,List2,List2b) :-
	
	
	%%split_string(String4,SepandPad,SepandPad,String21),
	
	%% go through s1, removing the first word each time, until v
	%%Length_string11 is Length_string1-1,
	length(List11,Length_string1),
	append(List11,List2,List1),
	Length_string2 is Length_string1+1,
	
%%writeln([list11,List11]),

	((%%trace,
	%%(List11=[z,a,b]->trace;true),
	%%writeln([[_,_,List11],String2]),
	%%notrace,
	not(List11=[]),

%%writeln(data_instance_k_classification1(Db
%%	,List11,1,A)),
	data_instance_k_classification1(Db
	%%String2
	,List11,1,A),
		%%writeln([string2,String2,list11,List11,a,A]),
A=String2,%%[_,_,List11],
	%%trace,
		
	%%((List11=[z,a,b],A=[_,_,[z,t,b]],not(String2=[_,_,[c,z]]))->trace;notrace),
	%%trace,
%%writeln([string2=list11,String2=List11]),
%%(List11=[y]->true%%trace
%%;true),
%%member(List11,Db),
	%%**String2=[_,_,List11]
	List2b=List2,%%,notrace
	String2=[_,_,String21]
	,writeln([found,String21,List11])
	)
	->(true
	%%,writeln(List11)
	);
	check_strings2(Length_string2,Length_string3,List1,String2,Db,_List2c,List2b)),!.

numbers(N2,N1,Numbers,Numbers) :-
	N2 is N1-1,!.
numbers(N2,N1,Numbers1,Numbers2) :-
	N3 is N1+1,
	append(Numbers1,[N1],Numbers3),
	numbers(N2,N3,Numbers3,Numbers2).

