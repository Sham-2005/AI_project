AI Maze Escape:  
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
