% Maze representation
wall(X,Y).
start(X,Y).
goal(X,Y).

% Possible movements
move((X,Y),(NX,Y)) :- NX is X+1.
move((X,Y),(NX,Y)) :- NX is X-1.
move((X,Y),(X,NY)) :- NY is Y+1.
move((X,Y),(X,NY)) :- NY is Y-1.

% Check whether a move is valid
valid((X,Y)) :-
    X >= 0, X < Rows,
    Y >= 0, Y < Cols,
    \+ wall(X,Y).

% Breadth-First Search (BFS)
bfs(Start, Goal, Path).

% Count steps
steps(Path, Count).