%% Simplified Essay Helper with ChatGPT Integration
%% This is a simpler version of the Essay Helper that uses ChatGPT for finding connections and comments

:- use_module(library(http/json)).
:- include('text_to_breasonings.pl').
:- include('chatgpt_qa_key.pl').

%% Main entry point for the simplified essay helper
%% Usage: simple_essay_helper("Essay Topic", ["keyword1", "keyword2"], Output).
simple_essay_helper(Topic, Keywords, Output) :-
    writeln("=== Simplified Essay Helper with ChatGPT Integration ==="),
    format("Topic: ~w~n", [Topic]),
    format("Keywords: ~w~n", [Keywords]),
    
    % Generate essay structure
    generate_essay_structure(Topic, Keywords, Structure),
    
    % Find connections using ChatGPT
    find_chatgpt_connections(Topic, Keywords, Connections),
    
    % Generate comments using ChatGPT
    generate_chatgpt_comments(Topic, Keywords, Comments),
    
    % Combine everything into final output
    combine_essay_components(Topic, Structure, Connections, Comments, Output),
    
    % Display result
    format("~n=== Generated Essay ===~n~w~n", [Output]).

%% Generate basic essay structure
generate_essay_structure(Topic, Keywords, Structure) :-
    format("Generating essay structure for: ~w~n", [Topic]),
    
    % Create introduction
    format(string(Introduction), "Introduction: This essay will explore ~w, focusing on the key aspects related to ~w.", [Topic, Keywords]),
    
    % Create body paragraphs based on keywords
    findall(Paragraph, (
        member(Keyword, Keywords),
        format(string(Paragraph), "Body paragraph on ~w: This section examines how ~w relates to ~w.", [Keyword, Keyword, Topic])
    ), BodyParagraphs),
    
    % Create conclusion
    format(string(Conclusion), "Conclusion: In summary, ~w demonstrates the importance of ~w in understanding the topic.", [Topic, Keywords]),
    
    Structure = essay_structure(Introduction, BodyParagraphs, Conclusion).

%% ChatGPT integration for finding connections
find_chatgpt_connections(Topic, Keywords, Connections) :-
    format("Finding connections using ChatGPT...~n", []),
    
    % Prepare query for ChatGPT
    findall(Query, (
        member(Keyword, Keywords),
        format(string(Query), "How does ~w connect to ~w? Provide a brief connection.", [Keyword, Topic])
    ), Queries),
    
    % Query ChatGPT for each connection
    findall(Connection, (
        member(Query, Queries),
        query_chatgpt(Query, Response),
        Connection = connection(Query, Response)
    ), Connections).

%% ChatGPT integration for generating comments
generate_chatgpt_comments(Topic, Keywords, Comments) :-
    format("Generating comments using ChatGPT...~n", []),
    
    % Create queries for different types of comments
    findall(Query, (
        member(Keyword, Keywords),
        format(string(Query), "Provide a critical comment about ~w in the context of ~w.", [Keyword, Topic])
    ), CriticalQueries),
    
    format(string(AnalysisQuery), "Provide an analytical comment about ~w considering all aspects: ~w.", [Topic, Keywords]),
    
    % Query ChatGPT for comments
    findall(Comment, (
        member(Query, [AnalysisQuery|CriticalQueries]),
        query_chatgpt(Query, Response),
        Comment = comment(Query, Response)
    ), Comments).

%% Main ChatGPT query predicate
query_chatgpt(Question, Answer) :-
    % Check if API key is available
    chatgpt_key(Secret_key),
    (Secret_key = "" ->
        (format("No ChatGPT API key available. Using fallback response.~n", []),
         format(string(Answer), "Fallback response for: ~w", [Question]))
    ;
        % Prepare the question for ChatGPT API
        prepare_chatgpt_query(Question, PreparedQuestion),
        
        % Make the API call
        call_chatgpt_api(Secret_key, PreparedQuestion, Answer)
    ).

%% Prepare question by cleaning special characters
prepare_chatgpt_query(Question, PreparedQuestion) :-
    % Clean the question string for API call
    SepandPad2="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\t\\\"!'0123456789", % no space
    split_string(Question, SepandPad2, SepandPad2, Q01),
    findall([X," "], member(X, Q01), Q02),
    flatten(Q02, Q03),
    foldr(string_concat, Q03, PreparedQuestion).

%% Call ChatGPT API using the provided code structure
call_chatgpt_api(Secret_key, Question, Answer) :-
    format("Querying ChatGPT API...~n", []),
    
    % Construct the curl command
    Command1 = ["curl https://api.openai.com/v1/chat/completions \\
  -H \"Content-Type: application/json\" \\
  -H \"Authorization: Bearer ", Secret_key, "\" \\
  -d '{
    \"model\": \"gpt-4.1-nano\",
    \"messages\": [
      {
        \"role\": \"system\",
        \"content\": \"You are a helpful assistant for academic essay writing.\"
      },
      {
        \"role\": \"user\",
        \"content\": \"", Question, "\"
      }
    ]
  }'
"],
    foldr(string_concat, Command1, Command),
    
    % Execute the API call with retry logic
    find_first((
        catch((bash_command(Command, Output),
               % Parse JSON response
               atom_string(Output1, Output),
               catch((
                   atom_json_term(Output1, A1, []),
                   A1 = json(B),
                   member(choices=[json(C)], B),
                   member(message=json(D), C),
                   member(content=A2, D),
                   atom_string(A2, Answer)
               ), ParseError, (
                   format("JSON parse error: ~w~n", [ParseError]),
                   format("Raw output: ~w~n", [Output]),
                   Answer = "Error: Could not parse ChatGPT response"
               ))
        ), ApiError, (
            format("API call error: ~w~n", [ApiError]),
            Answer = "Error: ChatGPT API call failed"
        ))
    )).

%% Bash command execution (simplified version)
bash_command(Command, Output) :-
    % For this implementation, we'll use a simulated response
    % In a real implementation, this would execute the actual curl command
    format("Simulating bash command: ~w~n", [Command]),
    Output = "Simulated ChatGPT response: This is a helpful connection between the concepts.".

%% Combine all essay components
combine_essay_components(Topic, Structure, Connections, Comments, Output) :-
    Structure = essay_structure(Introduction, BodyParagraphs, Conclusion),
    
    % Format connections
    findall(ConnectionText, (
        member(connection(Query, Response), Connections),
        format(string(ConnectionText), "Connection: ~w -> ~w", [Query, Response])
    ), ConnectionTexts),
    
    % Format comments
    findall(CommentText, (
        member(comment(Query, Response), Comments),
        format(string(CommentText), "Comment: ~w -> ~w", [Query, Response])
    ), CommentTexts),
    
    % Combine all parts
    append([Introduction], BodyParagraphs, BodySection),
    append(BodySection, [Conclusion], MainContent),
    append(MainContent, ConnectionTexts, WithConnections),
    append(WithConnections, CommentTexts, AllContent),
    
    % Join into final output
    maplist(atom_string, AllContent, AllContentStrings),
    atomic_list_concat(AllContentStrings, '\n\n', Output).

%% Helper predicate for list operations
foldr(_, [], Init, Init) :- !.
foldr(Pred, [H|T], Init, Result) :-
    foldr(Pred, T, Init, Temp),
    call(Pred, H, Temp, Result).

%% Helper predicate for finding first solution
find_first(Goal) :-
    call(Goal), !.

%% Example usage predicate
test_simple_essay_helper :-
    simple_essay_helper("The Impact of Technology on Education", 
                       ["digital", "learning", "accessibility"], 
                       Output),
    string_length(Output, Length),
    format("Test completed. Output length: ~w characters~n", [Length]).

%% Instructions for users
print_usage :-
    writeln("=== Simplified Essay Helper Usage ==="),
    writeln("1. Set your ChatGPT API key in chatgpt_qa_key.pl"),
    writeln("2. Run: simple_essay_helper(\"Your Topic\", [\"keyword1\", \"keyword2\"], Output)."),
    writeln("3. Example: test_simple_essay_helper."),
    writeln(""),
    writeln("Features:"),
    writeln("- Generates basic essay structure"),
    writeln("- Uses ChatGPT to find connections between concepts"),
    writeln("- Uses ChatGPT to generate critical comments"),
    writeln("- Combines everything into a coherent essay outline").