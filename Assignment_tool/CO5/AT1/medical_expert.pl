% ============================================================
% MEDI-EXPERT
% Rule-Based Medical Diagnosis Expert System
% SWI-Prolog
% ============================================================

:- dynamic has_symptom/2.
:- dynamic known/2.

% ------------------------------------------------------------
% SYMPTOM KNOWLEDGE
% ------------------------------------------------------------

symptom(fever).
symptom(cough).
symptom(sore_throat).
symptom(fatigue).
symptom(body_ache).
symptom(headache).
symptom(runny_nose).
symptom(nasal_congestion).
symptom(sneezing).
symptom(itchy_eyes).
symptom(wheezing).
symptom(shortness_of_breath).
symptom(chest_pain).
symptom(chest_tightness).
symptom(abdominal_pain).
symptom(vomiting).
symptom(diarrhea).
symptom(increased_thirst).
symptom(frequent_urination).
symptom(burning_urination).
symptom(skin_rash).
symptom(swollen_lymph_nodes).
symptom(nausea).

% ------------------------------------------------------------
% DIAGNOSIS RULES
% BACKWARD CHAINING RULES
% ------------------------------------------------------------

diagnosis(Patient, influenza_like_illness) :-
    has_symptom(Patient, fever),
    has_symptom(Patient, cough),
    has_symptom(Patient, fatigue),
    has_symptom(Patient, body_ache).

diagnosis(Patient, respiratory_infection) :-
    has_symptom(Patient, fever),
    has_symptom(Patient, cough),
    has_symptom(Patient, sore_throat).

diagnosis(Patient, asthma_related_condition) :-
    has_symptom(Patient, cough),
    has_symptom(Patient, wheezing),
    has_symptom(Patient, shortness_of_breath).

diagnosis(Patient, allergic_rhinitis) :-
    has_symptom(Patient, sneezing),
    has_symptom(Patient, runny_nose),
    has_symptom(Patient, itchy_eyes).

diagnosis(Patient, serious_respiratory_condition) :-
    has_symptom(Patient, fever),
    has_symptom(Patient, cough),
    has_symptom(Patient, shortness_of_breath).

diagnosis(Patient, viral_illness) :-
    has_symptom(Patient, headache),
    has_symptom(Patient, fever),
    has_symptom(Patient, body_ache).

diagnosis(Patient, gastrointestinal_infection) :-
    has_symptom(Patient, abdominal_pain),
    has_symptom(Patient, vomiting),
    has_symptom(Patient, diarrhea).

diagnosis(Patient, dehydration_risk) :-
    has_symptom(Patient, diarrhea),
    has_symptom(Patient, vomiting),
    has_symptom(Patient, fatigue).

diagnosis(Patient, diabetes_related_condition) :-
    has_symptom(Patient, increased_thirst),
    has_symptom(Patient, frequent_urination),
    has_symptom(Patient, fatigue).

diagnosis(Patient, urinary_tract_condition) :-
    has_symptom(Patient, burning_urination),
    has_symptom(Patient, frequent_urination),
    has_symptom(Patient, abdominal_pain).

diagnosis(Patient, urgent_cardiac_or_respiratory_evaluation) :-
    has_symptom(Patient, chest_pain),
    has_symptom(Patient, shortness_of_breath).

diagnosis(Patient, infectious_condition) :-
    has_symptom(Patient, skin_rash),
    has_symptom(Patient, fever),
    has_symptom(Patient, fatigue).

diagnosis(Patient, throat_infection) :-
    has_symptom(Patient, sore_throat),
    has_symptom(Patient, swollen_lymph_nodes),
    has_symptom(Patient, fever).

diagnosis(Patient, common_cold) :-
    has_symptom(Patient, runny_nose),
    has_symptom(Patient, sneezing),
    has_symptom(Patient, nasal_congestion).

diagnosis(Patient, common_cold) :-
    has_symptom(Patient, cough),
    has_symptom(Patient, runny_nose),
    has_symptom(Patient, sore_throat).

diagnosis(Patient, viral_condition) :-
    has_symptom(Patient, fever),
    has_symptom(Patient, headache),
    has_symptom(Patient, nausea).

diagnosis(Patient, metabolic_condition) :-
    has_symptom(Patient, fatigue),
    has_symptom(Patient, increased_thirst),
    has_symptom(Patient, frequent_urination).

diagnosis(Patient, abdominal_infection) :-
    has_symptom(Patient, abdominal_pain),
    has_symptom(Patient, fever),
    has_symptom(Patient, vomiting).

diagnosis(Patient, asthma) :-
    has_symptom(Patient, wheezing),
    has_symptom(Patient, chest_tightness),
    has_symptom(Patient, shortness_of_breath).

diagnosis(Patient, allergy) :-
    has_symptom(Patient, itchy_eyes),
    has_symptom(Patient, sneezing),
    has_symptom(Patient, runny_nose).


% ============================================================
% FORWARD CHAINING
% ============================================================

rule(
    influenza_like_illness,
    [fever, cough, fatigue, body_ache]
).

rule(
    respiratory_infection,
    [fever, cough, sore_throat]
).

rule(
    asthma_related_condition,
    [cough, wheezing, shortness_of_breath]
).

rule(
    allergic_rhinitis,
    [sneezing, runny_nose, itchy_eyes]
).

rule(
    serious_respiratory_condition,
    [fever, cough, shortness_of_breath]
).

rule(
    viral_illness,
    [headache, fever, body_ache]
).

rule(
    gastrointestinal_infection,
    [abdominal_pain, vomiting, diarrhea]
).

rule(
    dehydration_risk,
    [diarrhea, vomiting, fatigue]
).

rule(
    diabetes_related_condition,
    [increased_thirst, frequent_urination, fatigue]
).

rule(
    urinary_tract_condition,
    [burning_urination, frequent_urination, abdominal_pain]
).

rule(
    urgent_cardiac_or_respiratory_evaluation,
    [chest_pain, shortness_of_breath]
).

rule(
    infectious_condition,
    [skin_rash, fever, fatigue]
).

rule(
    throat_infection,
    [sore_throat, swollen_lymph_nodes, fever]
).

rule(
    common_cold,
    [runny_nose, sneezing, nasal_congestion]
).

rule(
    common_cold,
    [cough, runny_nose, sore_throat]
).

rule(
    viral_condition,
    [fever, headache, nausea]
).

rule(
    metabolic_condition,
    [fatigue, increased_thirst, frequent_urination]
).

rule(
    abdominal_infection,
    [abdominal_pain, fever, vomiting]
).

rule(
    asthma,
    [wheezing, chest_tightness, shortness_of_breath]
).

rule(
    allergy,
    [itchy_eyes, sneezing, runny_nose]
).


% ------------------------------------------------------------
% CHECK WHETHER ALL CONDITIONS ARE AVAILABLE
% ------------------------------------------------------------

all_true([], _).

all_true([H|T], Facts) :-
    member(H, Facts),
    all_true(T, Facts).


% ------------------------------------------------------------
% FORWARD CHAINING ENGINE
% ------------------------------------------------------------

forward_chain(Facts, Conclusions) :-
    forward_step(Facts, [], Conclusions).

forward_step(Facts, Conclusions, Conclusions) :-
    findall(Diagnosis,
            (
                rule(Diagnosis, Conditions),
                all_true(Conditions, Facts),
                \+ member(Diagnosis, Facts)
            ),
            NewConclusions),
    NewConclusions = [].

forward_step(Facts, OldConclusions, Conclusions) :-
    findall(Diagnosis,
            (
                rule(Diagnosis, Conditions),
                all_true(Conditions, Facts),
                \+ member(Diagnosis, Facts)
            ),
            NewConclusions),
    NewConclusions \= [],
    append(Facts, NewConclusions, UpdatedFacts),
    append(OldConclusions, NewConclusions, UpdatedConclusions),
    forward_step(UpdatedFacts, UpdatedConclusions, Conclusions).


% ------------------------------------------------------------
% FORWARD CHAINING WITH TRACE
% ------------------------------------------------------------

forward_diagnose(Facts) :-
    nl,
    write('===== FORWARD CHAINING ====='), nl,
    write('Initial facts: '),
    write(Facts), nl,
    forward_trace(Facts).

forward_trace(Facts) :-
    findall(Diagnosis,
            (
                rule(Diagnosis, Conditions),
                all_true(Conditions, Facts),
                \+ member(Diagnosis, Facts)
            ),
            NewConclusions),
    NewConclusions = [],
    nl,
    write('No more rules can be fired.'), nl,
    write('Final conclusions: '),
    write(Facts), nl.

forward_trace(Facts) :-
    findall(Diagnosis,
            (
                rule(Diagnosis, Conditions),
                all_true(Conditions, Facts),
                \+ member(Diagnosis, Facts)
            ),
            NewConclusions),
    NewConclusions \= [],
    nl,
    write('Rules fired: '),
    write(NewConclusions), nl,
    append(Facts, NewConclusions, UpdatedFacts),
    forward_trace(UpdatedFacts).


% ------------------------------------------------------------
% BACKWARD CHAINING
% ------------------------------------------------------------

backward_diagnose(Patient) :-
    nl,
    write('===== BACKWARD CHAINING ====='), nl,
    findall(Diagnosis,
            diagnosis(Patient, Diagnosis),
            Diagnoses),
    write('Possible conclusions: '),
    write(Diagnoses), nl.


% ------------------------------------------------------------
% EXPLANATION FACILITY
% ------------------------------------------------------------

explain(Patient, Diagnosis) :-
    diagnosis(Patient, Diagnosis),
    write('Diagnosis: '),
    write(Diagnosis), nl,
    write('Reasoning: '), nl,
    explain_rule(Patient, Diagnosis).

explain_rule(Patient, Diagnosis) :-
    diagnosis(Patient, Diagnosis),
    write('  Rule conditions satisfied for '),
    write(Diagnosis), nl.


% ------------------------------------------------------------
% INTERACTIVE PATIENT SETUP
% ------------------------------------------------------------

clear_patient(Patient) :-
    retractall(has_symptom(Patient, _)).

add_symptom(Patient, Symptom) :-
    symptom(Symptom),
    assertz(has_symptom(Patient, Symptom)).

show_symptoms(Patient) :-
    findall(Symptom,
            has_symptom(Patient, Symptom),
            Symptoms),
    write('Patient symptoms: '),
    write(Symptoms), nl.


% ------------------------------------------------------------
% SAMPLE PATIENTS
% ------------------------------------------------------------

sample_patient(patient1).

sample_patient(patient2).

sample_patient(patient3).


has_symptom(patient1, fever).
has_symptom(patient1, cough).
has_symptom(patient1, fatigue).
has_symptom(patient1, body_ache).

has_symptom(patient2, sneezing).
has_symptom(patient2, runny_nose).
has_symptom(patient2, itchy_eyes).

has_symptom(patient3, abdominal_pain).
has_symptom(patient3, vomiting).
has_symptom(patient3, diarrhea).


% ------------------------------------------------------------
% TESTING
% ------------------------------------------------------------

test_backward :-
    nl,
    write('Testing backward chaining for patient1'), nl,
    backward_diagnose(patient1).

test_forward :-
    nl,
    write('Testing forward chaining'), nl,
    findall(S, has_symptom(patient1, S), Symptoms),
    forward_diagnose(Symptoms).