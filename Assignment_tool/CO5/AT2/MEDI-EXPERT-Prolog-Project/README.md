# MEDI-EXPERT

Rule-based Medical Diagnosis Expert System using SWI-Prolog.

## Files

- `knowledge_base.pl` - symptoms, patients and production rules.
- `inference_engine.pl` - forward chaining, backward chaining and explanations.
- `main.pl` - interactive menu and demonstrations.

## Requirements

Install SWI-Prolog.

## Run

Open a terminal in this folder and run:

```text
swipl
```

At the Prolog prompt:

```prolog
[main].
start.
```

Or load everything explicitly:

```prolog
[knowledge_base].
[inference_engine].
[main].
start.
```

## Important test queries

```prolog
inference_engine:backward_diagnosis(patient1, X).
inference_engine:backward_diagnoses(patient1, X).
inference_engine:backward_diagnosis(patient2, influenza_like_illness).
```

Press `;` after a successful query to request another solution.

Forward chaining:

```prolog
main:patient_facts(patient1, Facts).
inference_engine:forward_chain_trace(Facts, Conclusions, Trace).
```

Run all demonstrations:

```prolog
main:run_demos.
```

## Academic scope

This is an educational rule-based expert-system prototype. It is not clinically validated and must not be used as medical advice or for real-world diagnosis.
