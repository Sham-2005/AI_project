# Minimax Algorithm

def minimax(depth, node_index, maximizing_player, values, max_depth):

    # If leaf node is reached
    if depth == max_depth:
        return values[node_index]

    if maximizing_player:
        best = float('-inf')

        for i in range(2):
            val = minimax(depth + 1,
                          node_index * 2 + i,
                          False,
                          values,
                          max_depth)
            best = max(best, val)

        return best

    else:
        best = float('inf')

        for i in range(2):
            val = minimax(depth + 1,
                          node_index * 2 + i,
                          True,
                          values,
                          max_depth)
            best = min(best, val)

        return best


# Leaf node values
values = [3, 5, 6, 9, 1, 2, 0, -1]

# Tree depth = 3 (8 leaf nodes)
max_depth = 3

result = minimax(0, 0, True, values, max_depth)

print("Optimal Value:", result)
