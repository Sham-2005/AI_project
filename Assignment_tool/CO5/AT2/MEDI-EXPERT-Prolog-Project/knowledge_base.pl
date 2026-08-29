% ============================================================
% MEDI-EXPERT - Knowledge Base
% Rule-based medical diagnosis academic demonstration
% ============================================================

:- module(knowledge_base,
          [ symptom/1,
            patient/1,
            has_symptom/2,
            rule/2,
            diagnosis_rule/2,
            sample_patients/0
          ]).

% ---------- Symptom vocabulary ----------

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

% ---------- Sample patients ----------

patient(patient1).
patient(patient2).
patient(patient3).
patient(patient4).
patient(patient5).

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

has_symptom(patient4, wheezing).
has_symptom(patient4, chest_tightness).
has_symptom(patient4, shortness_of_breath).

has_symptom(patient5, headache).

% ---------- Production rules ----------
% rule(Conclusion, RequiredSymptoms).

rule(influenza_like_illness,
     [fever, cough, fatigue, body_ache]).

rule(respiratory_infection,
     [fever, cough, sore_throat]).

rule(asthma_related_condition,
     [cough, wheezing, shortness_of_breath]).

rule(allergic_rhinitis,
     [sneezing, runny_nose, itchy_eyes]).

rule(serious_respiratory_condition,
     [fever, cough, shortness_of_breath]).

rule(viral_illness,
     [headache, fever, body_ache]).

rule(gastrointestinal_infection,
     [abdominal_pain, vomiting, diarrhea]).

rule(dehydration_risk,
     [diarrhea, vomiting, fatigue]).

rule(diabetes_related_condition,
     [increased_thirst, frequent_urination, fatigue]).

rule(urinary_tract_condition,
     [burning_urination, frequent_urination, abdominal_pain]).

rule(urgent_cardiac_or_respiratory_evaluation,
     [chest_pain, shortness_of_breath]).

rule(infectious_condition,
     [skin_rash, fever, fatigue]).

rule(throat_infection,
     [sore_throat, swollen_lymph_nodes, fever]).

rule(common_cold,
     [runny_nose, sneezing, nasal_congestion]).

rule(common_cold,
     [cough, runny_nose, sore_throat]).

rule(viral_condition,
     [fever, headache, nausea]).

rule(metabolic_condition,
     [fatigue, increased_thirst, frequent_urination]).

rule(abdominal_infection,
     [abdominal_pain, fever, vomiting]).

rule(asthma,
     [wheezing, chest_tightness, shortness_of_breath]).

rule(allergy,
     [itchy_eyes, sneezing, runny_nose]).

% ---------- Backward-chaining rules ----------
% diagnosis_rule(Condition, RequiredSymptoms).
% These are equivalent knowledge relationships expressed for
% goal-driven Prolog reasoning.

diagnosis_rule(Condition, Symptoms) :-
    rule(Condition, Symptoms).

sample_patients :-
    format("~nSample patients loaded:~n", []),
    forall(patient(P),
           ( format("  ~w: ", [P]),
             findall(S, has_symptom(P,S), Symptoms),
             writeln(Symptoms)
           )).
