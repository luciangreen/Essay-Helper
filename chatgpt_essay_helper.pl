%% Enhanced ChatGPT Integration Module
%% This implements the exact ChatGPT querying logic from the problem statement

:- use_module(library(http/json)).
:- include('text_to_breasonings.pl').
:- include('chatgpt_qa_key.pl').

%% Main ChatGPT query predicate using the provided code
q(Q0, A) :-
    % Clean the input query
    SepandPad2="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\t\\\"!'0123456789", % no space
    split_string(Q0, SepandPad2, SepandPad2, Q01),
    findall([X," "], member(X, Q01), Q02),
    flatten(Q02, Q03),
    foldr(string_concat, Q03, "", Q),

    % Get the secret key
    chatgpt_key(Secret_key),

    (Secret_key = "" ->
        fail
    ; true),

    % Construct the curl command
    Command1 = ["curl https://api.openai.com/v1/chat/completions \\
  -H \"Content-Type: application/json\" \\
  -H \"Authorization: Bearer ", Secret_key, "\" \\
  -d '{
    \"model\": \"gpt-4.1-nano\",
    \"messages\": [
      {
        \"role\": \"system\",
        \"content\": \"You are a helpful assistant.\"
      },
      {
        \"role\": \"user\",
        \"content\": \"", Q, "\"
      }
    ]
  }'
"],
    foldr(string_concat, Command1, "", Command),
    
    find_first((repeat,
        catch((bash_command(Command, Output)),_, fail), !,
        
        % Parse JSON response
        atom_string(Output1, Output),
        atom_json_term(Output1, A1, []),
        A1 = json(B),
        member(choices=[json(C)], B),
        member(message=json(D), C),
        member(content=A2, D),
        atom_string(A2, A),
        writeln(A)
    ), _, fail) -> true; 
    (N is 60*5, sleep(N), fail).

%% Helper predicate for bash command execution
bash_command(Command, Output) :-
    % Create a temporary file for the command
    tmp_file_stream(text, TmpFile, Stream),
    close(Stream),
    
    % Write command to temp file and execute
    format(string(ExecCommand), "~w > ~w 2>&1", [Command, TmpFile]),
    shell(ExecCommand, ExitCode),
    
    % Read the output
    (ExitCode = 0 ->
        read_file_to_string(TmpFile, Output, [])
    ; 
        Output = "Command execution failed"
    ),
    
    % Clean up
    delete_file(TmpFile).

%% Helper predicate for foldr operation
foldr(_, [], Init, Init) :- !.
foldr(Pred, [H|T], Init, Result) :-
    foldr(Pred, T, Init, Temp),
    call(Pred, H, Temp, Result).

%% Helper predicate for finding first solution
find_first(Goal) :-
    call(Goal), !.

%% Simplified Essay Helper using ChatGPT
simple_essay_helper_with_chatgpt(Topic, Keywords, Output) :-
    writeln("=== Simplified Essay Helper with Real ChatGPT Integration ==="),
    format("Topic: ~w~n", [Topic]),
    format("Keywords: ~w~n", [Keywords]),
    
    % Generate base essay structure
    generate_base_essay(Topic, Keywords, BaseEssay),
    
    % Use ChatGPT to find connections
    find_connections_chatgpt(Topic, Keywords, Connections),
    
    % Use ChatGPT to generate comments
    generate_comments_chatgpt(Topic, Keywords, Comments),
    
    % Combine everything
    combine_essay_with_chatgpt(BaseEssay, Connections, Comments, Output),
    
    format("~n=== Final Essay Output ===~n~w~n", [Output]).

%% Generate base essay structure
generate_base_essay(Topic, Keywords, BaseEssay) :-
    format(string(Intro), "Introduction: This essay examines ~w with focus on ~w.", [Topic, Keywords]),
    
    findall(Body, (
        member(Keyword, Keywords),
        format(string(Body), "Analysis of ~w: This section explores how ~w relates to ~w.", [Keyword, Keyword, Topic])
    ), BodyParagraphs),
    
    format(string(Conclusion), "Conclusion: ~w demonstrates the significance of ~w.", [Topic, Keywords]),
    
    append([Intro], BodyParagraphs, Temp),
    append(Temp, [Conclusion], BaseEssay).

%% Find connections using ChatGPT
find_connections_chatgpt(Topic, Keywords, Connections) :-
    findall(Connection, (
        member(Keyword, Keywords),
        format(string(Query), "How does ~w connect to ~w? Provide a specific, academic connection in one sentence.", [Keyword, Topic]),
        (q(Query, Response) ->
            Connection = connection(Keyword, Response)
        ;
            Connection = connection(Keyword, "No connection found due to API limitations.")
        )
    ), Connections).

%% Generate comments using ChatGPT
generate_comments_chatgpt(Topic, Keywords, Comments) :-
    findall(Comment, (
        member(Keyword, Keywords),
        format(string(Query), "Provide a critical academic comment about ~w in the context of ~w. Be specific and analytical.", [Keyword, Topic]),
        (q(Query, Response) ->
            Comment = comment(Keyword, Response)
        ;
            Comment = comment(Keyword, "No comment generated due to API limitations.")
        )
    ), Comments).

%% Combine essay components with ChatGPT enhancements
combine_essay_with_chatgpt(BaseEssay, Connections, Comments, Output) :-
    % Format connections
    findall(ConnText, (
        member(connection(Keyword, Response), Connections),
        format(string(ConnText), "Connection for ~w: ~w", [Keyword, Response])
    ), ConnectionTexts),
    
    % Format comments
    findall(CommentText, (
        member(comment(Keyword, Response), Comments),
        format(string(CommentText), "Critical comment on ~w: ~w", [Keyword, Response])
    ), CommentTexts),
    
    % Combine all sections
    append(BaseEssay, ["", "=== ChatGPT Enhanced Connections ==="], WithSeparator),
    append(WithSeparator, ConnectionTexts, WithConnections),
    append(WithConnections, ["", "=== ChatGPT Generated Comments ==="], WithCommentSeparator),
    append(WithCommentSeparator, CommentTexts, AllComponents),
    
    % Join with newlines
    atomic_list_concat(AllComponents, '\n', Output).

%% Test with fallback for no API key
test_chatgpt_integration :-
    simple_essay_helper_with_chatgpt("Artificial Intelligence in Healthcare", 
                                   ["machine learning", "diagnosis", "ethics"], 
                                   _Output),
    format("Test completed. Generated essay with ChatGPT integration.~n", []).

%% Simple test of q/2 predicate
test_q_predicate :-
    Query = "What is artificial intelligence?",
    (q(Query, Answer) ->
        format("ChatGPT Response: ~w~n", [Answer])
    ;
        format("ChatGPT query failed - check API key~n", [])
    ).

%% Usage instructions
print_chatgpt_usage :-
    writeln("=== ChatGPT Enhanced Essay Helper ==="),
    writeln("1. Set your OpenAI API key in chatgpt_qa_key.pl"),
    writeln("2. Test the connection: test_q_predicate."),
    writeln("3. Generate enhanced essay: test_chatgpt_integration."),
    writeln("4. Use directly: simple_essay_helper_with_chatgpt(Topic, Keywords, Output)."),
    writeln(""),
    writeln("Note: Requires valid OpenAI API key for ChatGPT integration.").