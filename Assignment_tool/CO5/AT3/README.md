# Cybersecurity Threat Detection - CO5 AT3

## Problem
A security operations center wants to identify threats from repeated login failures,
unusual login locations, privilege escalation, suspicious file access, and abnormal
network traffic.

## Files
- cyber_threat_detection.pl - complete SWI-Prolog model
- report.docx - assessment report
- README.md - execution guide

## SWI-Prolog execution

From the project directory:

```text
"C:\Program Files\swipl\bin\swipl.exe" cyber_threat_detection.pl
```

At the `?-` prompt:

```prolog
start.
```

Useful queries:

```prolog
run_demo.
run_tests.
backward_diagnoses(alice, X).
diagnosis(alice, major_security_threat).
forward_chain(alice, State, Trace).
```

If `swipl` is in PATH, simply use:

```text
swipl cyber_threat_detection.pl
```

## Important
This is an academic rule-based demonstration. It is not a production SOC/IDS/IPS and
does not replace real security monitoring, correlation, or incident-response systems.
