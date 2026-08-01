%==========================================
% Connect Four AI (Skeleton)
%==========================================

% Start the game
play :-
    writeln('Connect Four AI Started'),
    writeln('Board Size : 6 x 7'),
    writeln('Player = X'),
    writeln('Computer = O').

% Player move
player_move(Column) :-
    format('Player drops piece in column ~w~n',[Column]).

% AI move (placeholder)
ai_move(Column) :-
    format('AI drops piece in column ~w~n',[Column]).

% Win checking
check_win(player) :-
    writeln('Player Wins!').

check_win(ai) :-
    writeln('AI Wins!').

% Draw
draw :-
    writeln('Game Draw').