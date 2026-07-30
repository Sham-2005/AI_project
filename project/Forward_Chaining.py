# Forward Chaining

facts = ["A", "B"]

rules = [
    (["A", "B"], "C"),
    (["C"], "D"),
    (["D"], "E")
]

inferred = set(facts)

changed = True

while changed:
    changed = False

    for condition, result in rules:
        if all(c in inferred for c in condition) and result not in inferred:
            inferred.add(result)
            changed = True

print("Derived Facts:")
for fact in sorted(inferred):
    print(fact)
