# Propositional Logic Program

def implication(p, q):
    return (not p) or q

def biconditional(p, q):
    return p == q

# Input values
P = input("Enter value for P (True/False): ").strip().lower() == "true"
Q = input("Enter value for Q (True/False): ").strip().lower() == "true"

print("\nValues:")
print("P =", P)
print("Q =", Q)

# Logical Operations
print("\nLogical Operations:")
print("P AND Q =", P and Q)
print("P OR Q =", P or Q)
print("NOT P =", not P)
print("NOT Q =", not Q)
print("P -> Q =", implication(P, Q))
print("P <-> Q =", biconditional(P, Q))

# Truth Table
print("\nTruth Table:")
print("P\tQ\tAND\tOR\tNOT P\tNOT Q\tP->Q\tP<->Q")

for p in [True, False]:
    for q in [True, False]:
        print(
            p, "\t",
            q, "\t",
            p and q, "\t",
            p or q, "\t",
            not p, "\t",
            not q, "\t",
            implication(p, q), "\t",
            biconditional(p, q)
        )
