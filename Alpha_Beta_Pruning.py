MAX, MIN = 1000, -1000

# Alpha-Beta Pruning Function
def alpha_beta(depth, node_index, maximizing_player, values, alpha, beta):

    # Leaf node reached
    if depth == 3:
        return values[node_index]

    if maximizing_player:
        best = MIN

        for i in range(2):
            val = alpha_beta(depth + 1,
                             node_index * 2 + i,
                             False,
                             values,
                             alpha,
                             beta)

            best = max(best, val)
            alpha = max(alpha, best)

            # Beta Cutoff
            if beta <= alpha:
                break

        return best

    else:
        best = MAX

        for i in range(2):
            val = alpha_beta(depth + 1,
                             node_index * 2 + i,
                             True,
                             values,
                             alpha,
                             beta)

            best = min(best, val)
            beta = min(beta, best)

            # Alpha Cutoff
            if beta <= alpha:
                break

        return best

# Leaf node values
values = [3, 5, 6, 9, 1, 2, 0, -1]

result = alpha_beta(0, 0, True, values, MIN, MAX)

print("Optimal Value:", result)
