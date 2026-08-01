% ==========================================
% N-Queens Problem using Backtracking
% ==========================================

% Solve N-Queens
queens(N, Solution) :-
    numlist(1, N, List),
    permutation(List, Solution),
    safe(Solution).

% Base case
safe([]).

% Check each queen
safe([Q|Others]) :-
    safe(Others),
    no_attack(Q, Others, 1).

% Ensure no diagonal attacks
no_attack(_, [], _).

no_attack(Q, [Q1|Others], Distance) :-
    Q =\= Q1,
    abs(Q - Q1) =\= Distance,
    NextDistance is Distance + 1,
    no_attack(Q, Others, NextDistance).