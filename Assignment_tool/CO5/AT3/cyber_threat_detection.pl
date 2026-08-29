% MEDI-EXPERT: Cybersecurity Threat Detection
% SWI-Prolog 10.x
% Academic expert-system model for CO5_AT3.

:- dynamic event/2.

% ------------------------------------------------------------
% DOMAIN FACTS / EVENTS
% event(User, Event).
% ------------------------------------------------------------

sample_data :-
    retractall(event(_, _)),
    assertz(event(alice, repeated_login_failures)),
    assertz(event(alice, unusual_login_location)),
    assertz(event(alice, privilege_escalation)),
    assertz(event(alice, suspicious_file_access)),
    assertz(event(alice, abnormal_network_traffic)),

    assertz(event(bob, repeated_login_failures)),
    assertz(event(bob, unusual_login_location)),

    assertz(event(charlie, suspicious_file_access)),
    assertz(event(charlie, abnormal_network_traffic)),

    assertz(event(david, unusual_login_location)).

% ------------------------------------------------------------
% PRODUCTION RULES
%
% rule(Conclusion, User, RequiredEvents).
% ------------------------------------------------------------

rule(brute_force_attack, U,
     [repeated_login_failures(U)]).

rule(credential_compromise, U,
     [repeated_login_failures(U),
      unusual_login_location(U)]).

rule(account_compromise, U,
     [unusual_login_location(U),
      privilege_escalation(U)]).

rule(malware_suspected, U,
     [suspicious_file_access(U),
      abnormal_network_traffic(U)]).

rule(high_risk_incident, U,
     [account_compromise(U),
      suspicious_file_access(U)]).

rule(major_security_threat, U,
     [credential_compromise(U),
      abnormal_network_traffic(U)]).

% ------------------------------------------------------------
% EVENT PREDICATES
% ------------------------------------------------------------

holds(U, E) :-
    event(U, E).

holds(U, repeated_login_failures) :-
    event(U, repeated_login_failures).

holds(U, unusual_login_location) :-
    event(U, unusual_login_location).

holds(U, privilege_escalation) :-
    event(U, privilege_escalation).

holds(U, suspicious_file_access) :-
    event(U, suspicious_file_access).

holds(U, abnormal_network_traffic) :-
    event(U, abnormal_network_traffic).

% A derived conclusion can also be treated as a fact.
holds(U, Conclusion) :-
    rule(Conclusion, U, Conditions),
    all_true_conditions(U, Conditions).

all_true_conditions(_, []).

all_true_conditions(U, [C|Rest]) :-
    condition_holds(U, C),
    all_true_conditions(U, Rest).

condition_holds(U, C) :-
    holds(U, C).

% ------------------------------------------------------------
% FORWARD CHAINING
% ------------------------------------------------------------

forward_chaining(U, Conclusions, Trace) :-
    findall(E, event(U, E), InitialFacts),
    forward_loop(InitialFacts, [], Conclusions, Trace).

forward_loop(Facts, Trace0, Facts, Trace0) :-
    findall(
        Conclusion,
        (
            rule(Conclusion, U, Conditions),
            ground_conditions_from_facts(Conditions, Facts),
            \+ member(Conclusion, Facts)
        ),
        RawNew
    ),
    sort(RawNew, New),
    New = [].

forward_loop(Facts, Trace0, Conclusions, Trace) :-
    findall(
        Conclusion,
        (
            rule(Conclusion, U, Conditions),
            ground_conditions_from_facts(Conditions, Facts),
            \+ member(Conclusion, Facts)
        ),
        RawNew
    ),
    sort(RawNew, New),
    New \= [],
    append(Facts, New, UpdatedFacts),
    append(Trace0, [New], Trace1),
    forward_loop(UpdatedFacts, Trace1, Conclusions, Trace).

ground_conditions_from_facts([], _).

ground_conditions_from_facts([C|Rest], Facts) :-
    condition_template(C, Conclusion),
    member(Conclusion, Facts),
    ground_conditions_from_facts(Rest, Facts).

condition_template(repeated_login_failures(U), repeated_login_failures) :-
    nonvar(U).

condition_template(unusual_login_location(U), unusual_login_location) :-
    nonvar(U).

condition_template(privilege_escalation(U), privilege_escalation) :-
    nonvar(U).

condition_template(suspicious_file_access(U), suspicious_file_access) :-
    nonvar(U).

condition_template(abnormal_network_traffic(U), abnormal_network_traffic) :-
    nonvar(U).

condition_template(account_compromise(U), account_compromise) :-
    nonvar(U).

condition_template(credential_compromise(U), credential_compromise) :-
    nonvar(U).

condition_template(malware_suspected(U), malware_suspected) :-
    nonvar(U).

% ------------------------------------------------------------
% A simpler, user-specific forward chainer.
% It derives conclusion names while preserving the user.
% ------------------------------------------------------------

forward_chain(U, Conclusions, Trace) :-
    findall(E, event(U,E), Facts),
    forward_chain_facts(U, Facts, [], Conclusions, Trace).

forward_chain_facts(U, Facts, Trace0, Conclusions, Trace) :-
    findall(
        C,
        (
            rule(C, U, Conditions),
            conditions_in_state(U, Conditions, Facts),
            \+ member(C, Facts)
        ),
        Raw
    ),
    sort(Raw, New),
    (
        New = []
        ->
        Conclusions = Facts,
        Trace = Trace0
        ;
        append(Facts, New, NextFacts),
        append(Trace0, [New], NextTrace),
        forward_chain_facts(U, NextFacts, NextTrace,
                            Conclusions, Trace)
    ).

conditions_in_state(_, [], _).

conditions_in_state(U, [Condition|Rest], Facts) :-
    condition_name(Condition, Name),
    member(Name, Facts),
    conditions_in_state(U, Rest, Facts).

condition_name(repeated_login_failures(_), repeated_login_failures).
condition_name(unusual_login_location(_), unusual_login_location).
condition_name(privilege_escalation(_), privilege_escalation).
condition_name(suspicious_file_access(_), suspicious_file_access).
condition_name(abnormal_network_traffic(_), abnormal_network_traffic).
condition_name(account_compromise(_), account_compromise).
condition_name(credential_compromise(_), credential_compromise).
condition_name(malware_suspected(_), malware_suspected).

% ------------------------------------------------------------
% BACKWARD CHAINING
% diagnosis(User, Threat) recursively proves a goal.
% ------------------------------------------------------------

diagnosis(U, Threat) :-
    prove(U, Threat, []).

prove(_, Threat, _) :-
    member(Threat,
           [repeated_login_failures,
            unusual_login_location,
            privilege_escalation,
            suspicious_file_access,
            abnormal_network_traffic]),
    !,
    event(U, Threat).

prove(U, Threat, Visited) :-
    \+ member(Threat, Visited),
    rule(Threat, U, Conditions),
    prove_conditions(U, Conditions, [Threat|Visited]).

prove_conditions(_, [], _).

prove_conditions(U, [C|Rest], Visited) :-
    condition_to_goal(C, Goal),
    prove(U, Goal, Visited),
    prove_conditions(U, Rest, Visited).

condition_to_goal(repeated_login_failures(_), repeated_login_failures).
condition_to_goal(unusual_login_location(_), unusual_login_location).
condition_to_goal(privilege_escalation(_), privilege_escalation).
condition_to_goal(suspicious_file_access(_), suspicious_file_access).
condition_to_goal(abnormal_network_traffic(_), abnormal_network_traffic).
condition_to_goal(account_compromise(_), account_compromise).
condition_to_goal(credential_compromise(_), credential_compromise).
condition_to_goal(malware_suspected(_), malware_suspected).

backward_diagnoses(U, Threats) :-
    findall(T, diagnosis(U,T), Raw),
    sort(Raw, Threats).

% ------------------------------------------------------------
% EXPLANATION
% ------------------------------------------------------------

explain(U, Threat) :-
    rule(Threat, U, Conditions),
    format('Goal: ~w~n', [Threat]),
    format('Required conditions: ~w~n', [Conditions]),
    forall(
        member(C, Conditions),
        format('  Proven condition: ~w~n', [C])
    ).

% ------------------------------------------------------------
% DISPLAY / DEMONSTRATION
% ------------------------------------------------------------

show_events(U) :-
    findall(E, event(U,E), Events),
    format('Events for ~w: ~w~n', [U, Events]).

demo_forward(U) :-
    forward_chain(U, FinalState, Trace),
    format('~nFORWARD CHAINING - ~w~n', [U]),
    show_events(U),
    print_trace(Trace, 1),
    format('Final state: ~w~n', [FinalState]).

print_trace([], _).

print_trace([Step|Rest], N) :-
    format('Step ~w -> ~w~n', [N, Step]),
    N2 is N + 1,
    print_trace(Rest, N2).

demo_backward(U) :-
    backward_diagnoses(U, Threats),
    format('~nBACKWARD CHAINING - ~w~n', [U]),
    format('Possible conclusions: ~w~n', [Threats]).

demo_unification :-
    format('~nUNIFICATION / BACKTRACKING~n', []),
    format('Query: diagnosis(alice, X).~n', []),
    findall(X, diagnosis(alice, X), Solutions),
    format('Solutions: ~w~n', [Solutions]).

run_demo :-
    sample_data,
    writeln('============================================='),
    writeln(' CYBERSECURITY THREAT DETECTION EXPERT SYSTEM'),
    writeln('============================================='),
    demo_forward(alice),
    demo_backward(alice),
    demo_forward(bob),
    demo_backward(bob),
    demo_unification.

% ------------------------------------------------------------
% TEST CASES
% ------------------------------------------------------------

test_case(1, alice, major_security_threat, pass) :-
    diagnosis(alice, major_security_threat), !.

test_case(2, alice, high_risk_incident, pass) :-
    diagnosis(alice, high_risk_incident), !.

test_case(3, bob, credential_compromise, pass) :-
    diagnosis(bob, credential_compromise), !.

test_case(4, charlie, malware_suspected, pass) :-
    diagnosis(charlie, malware_suspected), !.

test_case(5, david, brute_force_attack, fail_expected) :-
    \+ diagnosis(david, brute_force_attack), !.

run_tests :-
    sample_data,
    forall(
        test_case(N, U, T, Result),
        format('TC~w: ~w / ~w -> ~w~n', [N,U,T,Result])
    ).

% ------------------------------------------------------------
% MENU
% ------------------------------------------------------------

start :-
    sample_data,
    menu.

menu :-
    nl,
    writeln('1. Show Alice events'),
    writeln('2. Forward chaining - Alice'),
    writeln('3. Backward chaining - Alice'),
    writeln('4. Forward chaining - Bob'),
    writeln('5. Backward chaining - Bob'),
    writeln('6. Unification / Backtracking'),
    writeln('7. Run all tests'),
    writeln('8. Run full demonstration'),
    writeln('0. Exit'),
    write('Choice: '),
    read(Choice),
    handle(Choice).

handle(1) :-
    show_events(alice), menu.

handle(2) :-
    demo_forward(alice), menu.

handle(3) :-
    demo_backward(alice), menu.

handle(4) :-
    demo_forward(bob), menu.

handle(5) :-
    demo_backward(bob), menu.

handle(6) :-
    demo_unification, menu.

handle(7) :-
    run_tests, menu.

handle(8) :-
    run_demo, menu.

handle(0) :-
    writeln('Exiting.').

handle(_) :-
    writeln('Invalid option.'),
    menu.

:- initialization(
    writeln('Cybersecurity Threat Detection model loaded. Run start.'),
    now
).
