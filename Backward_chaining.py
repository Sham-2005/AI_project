# Backward Chaining

rules = {
    "E": ["D"],
    "D": ["C"],
    "C": ["A", "B"]
}

facts = {"A", "B"}

def backward_chain(goal):
    if goal in facts:
        return True

    if goal not in rules:
        return False

    for subgoal in rules[goal]:
        if not backward_chain(subgoal):
            return False

    return True

goal = "E"

if backward_chain(goal):
    print(f"{goal} can be proved")
else:
    print(f"{goal} cannot be proved")
