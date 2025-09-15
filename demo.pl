%% Example demonstration of the Simplified Essay Helper
%% This file shows how to use the system with various scenarios

:- include('final_simple_essay_helper.pl').

%% Demo 1: Basic essay generation without ChatGPT
demo_basic_essay :-
    writeln("=== Demo 1: Basic Essay Generation (No ChatGPT) ==="),
    simplified_essay_helper("Climate Change and Renewable Energy", 
                          ["solar power", "wind energy", "sustainability"],
                          _Output),
    writeln("Demo 1 completed."), nl.

%% Demo 2: Different topic and keywords
demo_different_topic :-
    writeln("=== Demo 2: Different Topic ==="),
    simplified_essay_helper("Social Media Impact on Society", 
                          ["privacy", "communication", "mental health"],
                          _Output),
    writeln("Demo 2 completed."), nl.

%% Demo 3: Academic topic
demo_academic_topic :-
    writeln("=== Demo 3: Academic Topic ==="),
    simplified_essay_helper("Quantum Computing Applications", 
                          ["cryptography", "optimization", "simulation"],
                          _Output),
    writeln("Demo 3 completed."), nl.

%% Run all demos
run_all_demos :-
    writeln("Running all demonstrations of the Simplified Essay Helper"),
    writeln("=" * 60),
    demo_basic_essay,
    demo_different_topic,
    demo_academic_topic,
    writeln("All demonstrations completed successfully!").

%% Interactive demo
interactive_demo :-
    writeln("=== Interactive Essay Helper Demo ==="),
    write("Enter essay topic: "),
    read_line_to_string(user_input, Topic),
    write("Enter keywords (comma-separated): "),
    read_line_to_string(user_input, KeywordString),
    split_string(KeywordString, ",", " ", Keywords),
    simplified_essay_helper(Topic, Keywords, _Output),
    writeln("Interactive demo completed!").

%% Performance test
performance_test :-
    writeln("=== Performance Test ==="),
    get_time(StartTime),
    simplified_essay_helper("Test Topic", ["test1", "test2"], _Output),
    get_time(EndTime),
    Duration is EndTime - StartTime,
    format("Essay generation completed in ~2f seconds~n", [Duration]).

%% Test with edge cases
test_edge_cases :-
    writeln("=== Edge Cases Test ==="),
    
    % Empty keywords
    writeln("Testing with empty keywords:"),
    simplified_essay_helper("Sample Topic", [], _Output1),
    
    % Single keyword
    writeln("Testing with single keyword:"),
    simplified_essay_helper("Sample Topic", ["single"], _Output2),
    
    % Many keywords
    writeln("Testing with many keywords:"),
    simplified_essay_helper("Complex Topic", 
                          ["key1", "key2", "key3", "key4", "key5"], 
                          _Output3),
    
    writeln("Edge cases testing completed.").

%% Help system
help :-
    writeln("=== Simplified Essay Helper Demo Help ==="),
    writeln("Available commands:"),
    writeln("  run_all_demos.        - Run all predefined demonstrations"),
    writeln("  demo_basic_essay.     - Basic essay generation demo"),
    writeln("  demo_different_topic. - Different topic demo"),
    writeln("  demo_academic_topic.  - Academic topic demo"),
    writeln("  interactive_demo.     - Interactive essay creation"),
    writeln("  performance_test.     - Test generation speed"),
    writeln("  test_edge_cases.      - Test with edge cases"),
    writeln("  help.                 - Show this help"),
    writeln(""),
    writeln("Main function:"),
    writeln("  simplified_essay_helper(Topic, Keywords, Output)."),
    writeln(""),
    writeln("For full usage instructions:"),
    writeln("  print_usage_instructions.").

%% Startup message
startup_message :-
    writeln("Simplified Essay Helper Demo Loaded!"),
    writeln("Type 'help.' for available commands."),
    writeln("Type 'run_all_demos.' to see all demonstrations.").