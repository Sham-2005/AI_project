**AI Maze Escape**

    1. Put START in a queue.
    2. Mark START as visited.
    3. While queue is not empty:
          Remove the front cell.
          If it is GOAL:
               Stop.
          Otherwise:
               Add all valid neighboring cells
               (Up, Down, Left, Right)
               that are not walls and not visited.
    4. Reconstruct the path.
    5. Count the steps.


**Algorithm N-Queens**

    Start
    
    1. Create a list of numbers from 1 to N.
    2. Generate a permutation of the list.
       (Each number represents the column position of a queen.)
    3. Check whether any two queens attack each other diagonally.
    4. If there is no conflict:
           Print the solution.
       Else:
           Generate another permutation.
    5. Stop when a valid arrangement is found.
    
    End
 **Water Jug Puzzle:**  
 
    START
    Initialize (11L,9L) = (0,0)
    Repeat until 11L jug contains 8 litres:
        Fill 11L jug
        Pour water from 11L jug to 9L jug
        If 9L jug becomes full:
            Empty 9L jug
            Continue pouring remaining water
    
    STOP
**Connect Four AI Challenge:**

    Algorithm: Connect Four AI (Minimax)
    
    START
    
    1. Initialize the game board.
    2. Repeat until the game ends:
          If it is the player's turn:
               Read the column.
               Drop the piece.
          Else:
               Use Minimax with Alpha-Beta Pruning
               to choose the best move.
               Drop the AI piece.
    3. After each move:
          Check for four consecutive pieces
          horizontally, vertically, or diagonally.
    4. If a player gets four in a row:
          Declare the winner.
    5. If the board is full:
          Declare a draw.
    
    STOP
**8-Puzzle AI Challenge:**

    Algorithm: A* Search for 8-Puzzle
    
    START
    
    1. Put the initial state into the OPEN list.
    2. Set CLOSED list as empty.
    3. While OPEN is not empty:
          a. Remove the state with the lowest f(n).
          b. If it is the goal state:
                Print the solution path and STOP.
          c. Add the state to CLOSED.
          d. Generate all valid child states
             by moving the blank tile.
          e. For each child:
                Calculate:
                    g(n) = cost from start
                    h(n) = Manhattan Distance
                    f(n) = g(n) + h(n)
                If child is not in CLOSED:
                    Add child to OPEN.
    4. If OPEN becomes empty:
          Print "No Solution"
    
    STOP
