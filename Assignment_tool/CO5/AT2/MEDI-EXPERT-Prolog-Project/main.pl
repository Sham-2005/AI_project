% ============================================================
% MEDI-EXPERT - Main Program
% ============================================================

:- use_module(knowledge_base).
:- use_module(inference_engine).

start :-
    banner,
    menu.

banner :-
    nl,
    writeln('=============================================='),
    writeln('              MEDI-EXPERT'),
    writeln('     Rule-Based Medical Expert System'),
    writeln('=============================================='),
    writeln('Academic demonstration only - not medical advice.'),
    nl.

menu :-
    repeat,
    writeln('1. Show sample patients'),
    writeln('2. Diagnose a sample patient'),
    writeln('3. Forward chaining'),
    writeln('4. Backward chaining'),
    writeln('5. Explain a diagnosis'),
    writeln('6. Test unification/backtracking'),
    writeln('7. Run all demonstrations'),
    writeln('0. Exit'),
    write('Choose an option: '),
    read(Choice),
    handle_choice(Choice),
    Choice == 0, !.

handle_choice(1) :-
    knowledge_base:sample_patients,
    nl.

handle_choice(2) :-
    choose_patient(Patient),
    inference_engine:backward_diagnoses(Patient, Diagnoses),
    format("~nPossible diagnoses for ~w:~n", [Patient]),
    print_list(Diagnoses),
    nl.

handle_choice(3) :-
    choose_patient(Patient),
    patient_facts(Patient, Facts),
    inference_engine:forward_chain_trace(Facts, Conclusions, Trace),
    format("~nFORWARD CHAINING FOR ~w~n", [Patient]),
    format("Initial facts: ~w~n", [Facts]),
    print_trace(Trace, 1),
    format("Final conclusions: ~w~n", [Conclusions]),
    nl.

handle_choice(4) :-
    choose_patient(Patient),
    format("~nBACKWARD CHAINING FOR ~w~n", [Patient]),
    forall(inference_engine:backward_diagnosis(Patient, Diagnosis),
           format("Goal satisfied: ~w~n", [Diagnosis])),
    nl.

handle_choice(5) :-
    choose_patient(Patient),
    inference_engine:backward_diagnoses(Patient, Diagnoses),
    explain_all(Patient, Diagnoses),
    nl.

handle_choice(6) :-
    writeln('Unification example: diagnosis(Patient, Condition).'),
    writeln('Run the query below at the Prolog prompt:'),
    writeln('    inference_engine:backward_diagnosis(patient1, X).'),
    writeln('Then press ; to request another solution.'),
    nl.

handle_choice(7) :-
    run_demos.

handle_choice(0) :-
    writeln('Exiting MEDI-EXPERT.').

handle_choice(_) :-
    writeln('Invalid option. Please choose 0 to 7.').

choose_patient(Patient) :-
    repeat,
    write('Enter patient (patient1..patient5): '),
    read(Patient),
    ( knowledge_base:patient(Patient) ->
        !
    ;
        writeln('Unknown patient. Try again.'),
        fail
    ).

patient_facts(Patient, Facts) :-
    findall(S, knowledge_base:has_symptom(Patient,S), Facts).

print_list([]) :-
    writeln('  (none)').
print_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_list(T).

print_trace([], _).
print_trace([Step|Rest], N) :-
    format('Step ~w: rule(s) fired -> ~w~n', [N, Step]),
    N2 is N + 1,
    print_trace(Rest, N2).

explain_all(_, []) :-
    writeln('No supported diagnosis to explain.').
explain_all(Patient, [D|Rest]) :-
    inference_engine:explain_diagnosis(Patient, D, Symptoms),
    format('~nDiagnosis: ~w~n', [D]),
    format('Supporting symptoms: ~w~n', [Symptoms]),
    explain_all(Patient, Rest).

run_demos :-
    writeln('=============================================='),
    writeln('           MEDI-EXPERT DEMONSTRATION'),
    writeln('=============================================='),

    % Demo 1: backward chaining
    writeln('~n[1] BACKWARD CHAINING'),
    inference_engine:backward_diagnoses(patient1, D1),
    format('patient1 -> ~w~n', [D1]),

    % Demo 2: forward chaining
    writeln('~n[2] FORWARD CHAINING'),
    patient_facts(patient1, Facts1),
    inference_engine:forward_chain_trace(Facts1, C1, T1),
    format('Initial facts -> ~w~n', [Facts1]),
    print_trace(T1, 1),
    format('Final conclusions -> ~w~n', [C1]),

    % Demo 3: negative test
    writeln('~n[3] NEGATIVE TEST'),
    ( inference_engine:backward_diagnosis(patient2, influenza_like_illness) ->
        writeln('Unexpected: diagnosis succeeded.')
    ;
        writeln('Expected: patient2 does not satisfy influenza_like_illness.')
    ),

    % Demo 4: unification/backtracking
    writeln('~n[4] UNIFICATION / BACKTRACKING'),
    writeln('Query: inference_engine:backward_diagnosis(patient1, X).'),
    findall(X,
            inference_engine:backward_diagnosis(patient1, X),
            Solutions),
    format('Solutions returned: ~w~n', [Solutions]),

    writeln('~nDemonstration completed.').

% Automatically show how to start when the file is loaded.
:- initialization(load_message, now).

load_message :-
    writeln('MEDI-EXPERT loaded. Run: start.').
