from collections import deque

# Function to perform BFS
def bfs(graph, start):
    visited = set()          # To keep track of visited nodes
    queue = deque([start])   # Create a queue and add start node

    visited.add(start)

    print("BFS Traversal:")

    while queue:
        node = queue.popleft()   # Remove the front node
        print(node, end=" ")

        # Visit all adjacent nodes
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)

# Graph represented as an adjacency list
graph = {
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': ['F'],
    'F': []
}

# Starting node
start_node = 'A'

# Call BFS function
bfs(graph, start_node)
