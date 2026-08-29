% ============================================================
% MEDI-EXPERT - Inference Engine
% ============================================================

:- module(inference_engine,
          [ forward_chain/2,
            forward_chain_trace/3,
            backward_diagnoses/2,
            backward_diagnosis/2,
            explain_diagnosis/3,
            all_true/2
          ]).

:- use_module(knowledge_base).

% ---------- Utility ----------

all_true([], _).
all_true([H|T], Facts) :-
    memberchk(H, Facts),
    all_true(T, Facts).

% ---------- Forward chaining ----------

forward_chain(Facts, Conclusions) :-
    forward_chain_trace(Facts, Conclusions, _).

forward_chain_trace(Facts, Conclusions, Trace) :-
    forward_step(Facts, [], Conclusions, [], Trace).

forward_step(Facts, Acc, Acc, Trace, Trace) :-
    findall(Diagnosis,
            ( knowledge_base:rule(Diagnosis, Conditions),
              all_true(Conditions, Facts),
              \+ memberchk(Diagnosis, Facts)
            ),
            New),
    New = [].

forward_step(Facts, Acc, Conclusions, Trace0, Trace) :-
    findall(Diagnosis,
            ( knowledge_base:rule(Diagnosis, Conditions),
              all_true(Conditions, Facts),
              \+ memberchk(Diagnosis, Facts)
            ),
            New),
    New \= [],
    append(Facts, New, UpdatedFacts),
    append(Acc, New, UpdatedAcc),
    append(Trace0, [New], Trace1),
    forward_step(UpdatedFacts, UpdatedAcc, Conclusions, Trace1, Trace).

% ---------- Backward chaining ----------
% Prolog resolves the diagnosis goal by recursively proving
% each required symptom.

backward_diagnosis(Patient, Diagnosis) :-
    knowledge_base:diagnosis_rule(Diagnosis, Symptoms),
    required_symptoms_present(Patient, Symptoms).

required_symptoms_present(_, []).
required_symptoms_present(Patient, [S|Rest]) :-
    knowledge_base:has_symptom(Patient, S),
    required_symptoms_present(Patient, Rest).

backward_diagnoses(Patient, Diagnoses) :-
    findall(Diagnosis,
            backward_diagnosis(Patient, Diagnosis),
            Raw),
    sort(Raw, Diagnoses).

% ---------- Explanation ----------

explain_diagnosis(Patient, Diagnosis, Symptoms) :-
    backward_diagnosis(Patient, Diagnosis),
    knowledge_base:rule(Diagnosis, Symptoms).
