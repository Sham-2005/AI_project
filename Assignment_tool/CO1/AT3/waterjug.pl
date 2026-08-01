%=========================================
% Water Jug Problem (11L and 9L)
% Goal: Get exactly 8 litres
%=========================================

solve :-
    write('Start State : (0,0)'), nl,

    write('1. Fill 11L Jug           -> (11,0)'), nl,
    write('2. Pour 11L -> 9L         -> (2,9)'), nl,
    write('3. Empty 9L Jug           -> (2,0)'), nl,
    write('4. Pour 11L -> 9L         -> (0,2)'), nl,
    write('5. Fill 11L Jug           -> (11,2)'), nl,
    write('6. Pour 11L -> 9L         -> (4,9)'), nl,
    write('7. Empty 9L Jug           -> (4,0)'), nl,
    write('8. Pour 11L -> 9L         -> (0,4)'), nl,
    write('9. Fill 11L Jug           -> (11,4)'), nl,
    write('10. Pour 11L -> 9L        -> (6,9)'), nl,
    write('11. Empty 9L Jug          -> (6,0)'), nl,
    write('12. Pour 11L -> 9L        -> (0,6)'), nl,
    write('13. Fill 11L Jug          -> (11,6)'), nl,
    write('14. Pour 11L -> 9L        -> (8,9)'), nl,

    nl,
    write('Goal Achieved!'), nl,
    write('11L Jug = 8 Litres'), nl,
    write('9L Jug = 9 Litres'), nl,
    write('Minimum Moves = 14'), nl.