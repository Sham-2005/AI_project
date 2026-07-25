1. Breadth First Search (BFS)
BFS(Graph, Start)

Create Queue
Create Visited Set

Add Start to Queue
Mark Start as Visited

While Queue is not Empty
    Remove Front Node
    Print Node

    For each Neighbor of Node
        If Neighbor not Visited
            Mark Neighbor as Visited
            Add Neighbor to Queue
End While
2. Depth First Search (DFS)
DFS(Node)

Mark Node as Visited
Print Node

For each Neighbor of Node
    If Neighbor not Visited
        DFS(Neighbor)
End For
3. Uniform Cost Search (UCS)
UCS(Start, Goal)

Create Priority Queue
Insert Start with Cost 0

While Queue is not Empty
    Remove Node with Lowest Cost

    If Node = Goal
        Return Solution

    For each Neighbor
        NewCost = CurrentCost + EdgeCost
        Insert Neighbor with NewCost
End While
4. Best First Search (Greedy Search)
BestFirstSearch(Start, Goal)

Create Priority Queue
Insert Start using Heuristic Value

While Queue is not Empty
    Remove Node with Lowest Heuristic

    If Node = Goal
        Return Solution

    Mark Node as Visited

    For each Neighbor
        If Neighbor not Visited
            Insert Neighbor using Heuristic
End While
5. A* Search Algorithm
AStar(Start, Goal)

Create Priority Queue

f(n) = g(n) + h(n)

Insert Start

While Queue is not Empty
    Remove Node with Lowest f(n)

    If Node = Goal
        Return Path

    For each Neighbor
        g = CurrentCost + EdgeCost
        f = g + Heuristic

        Insert Neighbor with f
End While
6. Minimax Algorithm
MINIMAX(Node, Depth, Maximizing)

If Leaf Node
    Return Value

If Maximizing
    Best = -∞

    For each Child
        Best = Max(Best, MINIMAX(Child))
    Return Best

Else
    Best = +∞

    For each Child
        Best = Min(Best, MINIMAX(Child))
    Return Best
7. Alpha-Beta Pruning
AlphaBeta(Node, Depth, Alpha, Beta, Maximizing)

If Leaf Node
    Return Value

If Maximizing
    For each Child
        Alpha = Max(Alpha, AlphaBeta(Child))

        If Alpha ≥ Beta
            Break

    Return Alpha

Else
    For each Child
        Beta = Min(Beta, AlphaBeta(Child))

        If Beta ≤ Alpha
            Break

    Return Beta
8. Forward Chaining
ForwardChaining(Facts, Rules)

Repeat

    For each Rule
        If Conditions are True
            Add Conclusion to Facts

Until No New Facts

Return Facts
9. Backward Chaining
BackwardChaining(Goal)

If Goal is Fact
    Return True

Find Rule producing Goal

For each Condition
    If BackwardChaining(Condition)
        Continue
    Else
        Return False

Return True
10. Propositional Logic
Input P, Q

AND = P AND Q
OR = P OR Q
NOT = NOT P
IMPLICATION = (NOT P) OR Q
BICONDITIONAL = (P = Q)

Display Results
