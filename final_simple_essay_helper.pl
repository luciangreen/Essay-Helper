%% Final Simplified Essay Helper with ChatGPT Integration
%% This implements a clean, working version of the Essay Helper with ChatGPT support

:- use_module(library(http/json)).
:- include('text_to_breasonings.pl').
:- include('chatgpt_qa_key.pl').

%% Main ChatGPT query predicate - simplified but robust
query_chatgpt_simple(Question, Answer) :-
    % Check if API key is available
    chatgpt_key(Secret_key),
    (Secret_key = "" ->
        format("No ChatGPT API key available. Using fallback.~n", []),
        Answer = "Fallback response due to missing API key."
    ;
        % Clean the question
        clean_question(Question, CleanQuestion),
        
        % Try to call ChatGPT API
        (call_chatgpt_api_safe(Secret_key, CleanQuestion, Answer) ->
            true
        ;
            Answer = "ChatGPT API call failed - using fallback response."
        )
    ).

%% Clean question for API call
clean_question(Question, CleanQuestion) :-
    % Simple cleaning - remove problematic characters
    atom_string(Question, QuestionStr),
    split_string(QuestionStr, "\"'\\", " ", Parts),
    atomic_list_concat(Parts, " ", CleanQuestion).

%% Safe API call with proper error handling
call_chatgpt_api_safe(Secret_key, Question, Answer) :-
    % Construct curl command safely
    format(string(JsonData), '{
        "model": "gpt-3.5-turbo",
        "messages": [
            {
                "role": "system",
                "content": "You are a helpful assistant for academic essay writing."
            },
            {
                "role": "user", 
                "content": "~w"
            }
        ],
        "max_tokens": 150
    }', [Question]),
    
    % Create temporary files for request and response
    tmp_file_stream(text, RequestFile, RequestStream),
    write(RequestStream, JsonData),
    close(RequestStream),
    
    tmp_file_stream(text, ResponseFile, ResponseStream), 
    close(ResponseStream),
    
    % Execute curl command
    format(string(CurlCmd), 'curl -s -X POST https://api.openai.com/v1/chat/completions -H "Content-Type: application/json" -H "Authorization: Bearer ~w" -d @~w > ~w 2>&1', [Secret_key, RequestFile, ResponseFile]),
    
    % Execute and handle response
    shell(CurlCmd, ExitCode),
    
    (ExitCode = 0 ->
        (read_file_to_string(ResponseFile, ResponseText, []),
         parse_chatgpt_response(ResponseText, Answer))
    ;
        Answer = "API call execution failed"
    ),
    
    % Cleanup
    delete_file(RequestFile),
    delete_file(ResponseFile).

%% Parse ChatGPT JSON response
parse_chatgpt_response(ResponseText, Answer) :-
    catch(
        (atom_string(ResponseAtom, ResponseText),
         atom_json_term(ResponseAtom, JsonTerm, []),
         JsonTerm = json(ResponseData),
         member(choices=ChoicesList, ResponseData),
         ChoicesList = [json(FirstChoice)|_],
         member(message=json(MessageData), FirstChoice),
         member(content=Answer, MessageData)
        ),
        Error,
        (format("JSON parsing failed: ~w~n", [Error]),
         Answer = "Failed to parse ChatGPT response")
    ).

%% Main simplified essay helper
simplified_essay_helper(Topic, Keywords, EssayOutput) :-
    writeln("=== Simplified Essay Helper with ChatGPT ==="),
    format("Topic: ~w~n", [Topic]),
    format("Keywords: ~w~n", [Keywords]),
    
    % Generate basic structure
    create_essay_structure(Topic, Keywords, Structure),
    
    % Enhance with ChatGPT connections
    enhance_with_connections(Topic, Keywords, Connections),
    
    % Generate ChatGPT comments
    generate_analytical_comments(Topic, Keywords, Comments),
    
    % Combine all parts
    assemble_final_essay(Structure, Connections, Comments, EssayOutput),
    
    % Display result
    format("~n=== Generated Essay ===~n~w~n", [EssayOutput]).

%% Create basic essay structure
create_essay_structure(Topic, Keywords, Structure) :-
    % Introduction
    format(string(Introduction), "Introduction:\\nThis essay examines ~w, with particular attention to key aspects including ~w.", [Topic, Keywords]),
    
    % Body paragraphs
    findall(Paragraph, (
        member(Keyword, Keywords),
        format(string(Paragraph), "Body Section - ~w:\\nThis section analyzes how ~w relates to and impacts ~w.", [Keyword, Keyword, Topic])
    ), BodyParagraphs),
    
    % Conclusion
    format(string(Conclusion), "Conclusion:\\nIn summary, the analysis of ~w reveals the significant role of ~w in understanding this topic.", [Topic, Keywords]),
    
    Structure = [Introduction|BodyParagraphs] + [Conclusion].

%% Enhance with ChatGPT-generated connections
enhance_with_connections(Topic, Keywords, Connections) :-
    findall(Connection, (
        member(Keyword, Keywords),
        format(string(Query), "How does ~w specifically connect to ~w? Provide one clear connection.", [Keyword, Topic]),
        query_chatgpt_simple(Query, Response),
        format(string(Connection), "Connection (~w): ~w", [Keyword, Response])
    ), Connections).

%% Generate analytical comments using ChatGPT
generate_analytical_comments(Topic, Keywords, Comments) :-
    findall(Comment, (
        member(Keyword, Keywords),
        format(string(Query), "Provide a brief critical analysis of ~w in the context of ~w.", [Keyword, Topic]),
        query_chatgpt_simple(Query, Response),
        format(string(Comment), "Analysis (~w): ~w", [Keyword, Response])
    ), Comments).

%% Assemble final essay from all components
assemble_final_essay(Structure, Connections, Comments, EssayOutput) :-
    % Extract structure parts
    Structure = BaseStructure + [Conclusion],
    
    % Combine all sections
    append(BaseStructure, ["\\n=== Enhanced Connections ==="], WithConnections),
    append(WithConnections, Connections, WithAllConnections),
    append(WithAllConnections, ["\\n=== Critical Analysis ==="], WithAnalysis),
    append(WithAnalysis, Comments, WithAllComments),
    append(WithAllComments, ["\\n"], WithConclusionSep),
    append(WithConclusionSep, [Conclusion], AllParts),
    
    % Join with newlines
    atomic_list_concat(AllParts, '\\n\\n', EssayOutput).

%% Test function
test_simplified_helper :-
    simplified_essay_helper("Digital Transformation in Education", 
                          ["technology", "pedagogy", "accessibility"],
                          _Output),
    writeln("Test completed successfully!").

%% Test ChatGPT connection directly
test_chatgpt_direct :-
    query_chatgpt_simple("What is the main benefit of AI in education?", Response),
    format("ChatGPT Response: ~w~n", [Response]).

%% Print usage instructions
print_usage_instructions :-
    writeln("=== Simplified Essay Helper Usage ==="),
    writeln("1. (Optional) Set your OpenAI API key in chatgpt_qa_key.pl"),
    writeln("   - Edit the file and replace the empty string with your key"),
    writeln("   - Format: chatgpt_key(\"sk-your-api-key-here\")."),
    writeln(""),
    writeln("2. Test the system:"),
    writeln("   - test_simplified_helper.  % Full essay generation"),
    writeln("   - test_chatgpt_direct.     % Test ChatGPT connection"),
    writeln(""),
    writeln("3. Use directly:"),
    writeln("   simplified_essay_helper(\"Your Topic\", [\"keyword1\", \"keyword2\"], Output)."),
    writeln(""),
    writeln("Features:"),
    writeln("- Generates structured essays with intro, body, and conclusion"),
    writeln("- Uses ChatGPT to find connections between concepts (if API key provided)"),
    writeln("- Uses ChatGPT to generate critical analysis (if API key provided)"),
    writeln("- Falls back gracefully when ChatGPT is unavailable"),
    writeln("- Simple, clean implementation focused on core functionality").