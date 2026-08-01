AI Maze Escape:  
    Put START in a queue.
    Mark START as visited.
    While queue is not empty:
        Remove the front cell.
        If it is GOAL:
            Stop.
        Otherwise:
            Add all valid neighboring cells
            (Up, Down, Left, Right)
            that are not walls and not visited.
    Reconstruct the path.
    Count the steps.
