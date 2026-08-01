AI Maze Escape

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


Algorithm N-Queens

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
