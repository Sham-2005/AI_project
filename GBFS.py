import heapq

def best_first_search(graph, heuristic, start, goal):
    visited = set()
    priority_queue = [(heuristic[start], start)]

    while priority_queue:
        h, node = heapq.heappop(priority_queue)

        if node == goal:
            print("Goal Found:", node)
            return

        visited.add(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                heapq.heappush(
                    priority_queue,
                    (heuristic[neighbor], neighbor)
                )

graph = {
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': [],
    'F': ['G'],
    'G': []
}

heuristic = {
    'A': 6,
    'B': 4,
    'C': 3,
    'D': 5,
    'E': 2,
    'F': 1,
    'G': 0
}

best_first_search(graph, heuristic, 'A', 'G')
