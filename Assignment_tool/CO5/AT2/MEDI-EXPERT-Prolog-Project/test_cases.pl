% ============================================================
% MEDI-EXPERT - Test Cases
% ============================================================

:- use_module(knowledge_base).
:- use_module(inference_engine).

run_tests :-
    test_1,
    test_2,
    test_3,
    test_4,
    test_5,
    test_6,
    writeln(''),
    writeln('All test cases completed.').

test_1 :-
    inference_engine:backward_diagnosis(patient1, influenza_like_illness),
    writeln('TC01 PASS - patient1 satisfies influenza_like_illness.').

test_2 :-
    inference_engine:backward_diagnosis(patient2, allergic_rhinitis),
    writeln('TC02 PASS - patient2 satisfies allergic_rhinitis.').

test_3 :-
    inference_engine:backward_diagnosis(patient3, gastrointestinal_infection),
    writeln('TC03 PASS - patient3 satisfies gastrointestinal_infection.').

test_4 :-
    inference_engine:backward_diagnosis(patient4, asthma),
    writeln('TC04 PASS - patient4 satisfies asthma.').

test_5 :-
    \+ inference_engine:backward_diagnosis(patient5, influenza_like_illness),
    writeln('TC05 PASS - patient5 does not satisfy influenza_like_illness.').

test_6 :-
    knowledge_base:has_symptom(patient1, fever),
    knowledge_base:has_symptom(patient1, cough),
    writeln('TC06 PASS - fact lookup/unification succeeds.').
