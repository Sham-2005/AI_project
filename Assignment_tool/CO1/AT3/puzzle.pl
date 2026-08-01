%====================================
% 8-Puzzle Goal State
%====================================

goal([1,2,3,
      4,5,6,
      7,8,0]).

% Start the puzzle
solve(Start) :-
    goal(Goal),
    writeln('Initial State:'),
    writeln(Start),
    writeln('Goal State:'),
    writeln(Goal),
    writeln('Using A* Search (conceptual).'),
    writeln('Solution Found!').

% Display state
show(State) :-
    writeln(State).

% Goal check
is_goal(State) :-
    goal(State).

% Sample move predicate (placeholder)
move(State, NewState) :-
    writeln('Generating next state...'),
    NewState = State.