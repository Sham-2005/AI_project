import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.metrics import (
    accuracy_score,
    precision_score,
    recall_score,
    f1_score,
    confusion_matrix,
    classification_report
)


# ============================================================
# 1. LOAD DATASET
# ============================================================

# Change this to your actual dataset filename
FILE_NAME = "loan_approval.csv"

try:
    df = pd.read_csv(FILE_NAME)
    print("Dataset loaded successfully.")
except FileNotFoundError:
    print("Dataset not found. Creating demonstration dataset...")

    np.random.seed(42)

    n = 1000

    income = np.random.randint(20000, 150000, n)
    credit_score = np.random.randint(300, 850, n)

    employment_status = np.random.choice(
        ["Employed", "Self-Employed", "Unemployed"],
        n,
        p=[0.65, 0.25, 0.10]
    )

    loan_amount = np.random.randint(50000, 1000000, n)

    repayment_history = np.random.choice(
        ["Good", "Average", "Poor"],
        n,
        p=[0.60, 0.25, 0.15]
    )

    # Generate target based on simple loan approval rules
    eligible = []

    for i in range(n):

        score = 0

        if income[i] >= 50000:
            score += 1

        if credit_score[i] >= 650:
            score += 2

        if employment_status[i] in ["Employed", "Self-Employed"]:
            score += 1

        if loan_amount[i] <= income[i] * 8:
            score += 1

        if repayment_history[i] == "Good":
            score += 2
        elif repayment_history[i] == "Average":
            score += 1

        if score >= 5:
            eligible.append("Eligible")
        else:
            eligible.append("Not Eligible")

    df = pd.DataFrame({
        "Income": income,
        "CreditScore": credit_score,
        "EmploymentStatus": employment_status,
        "LoanAmount": loan_amount,
        "RepaymentHistory": repayment_history,
        "LoanStatus": eligible
    })

    df.to_csv(FILE_NAME, index=False)

    print(f"Demonstration dataset created: {FILE_NAME}")


# ============================================================
# 2. DISPLAY DATASET INFORMATION
# ============================================================

print("\n========== FIRST 5 ROWS ==========")
print(df.head())

print("\n========== DATASET SHAPE ==========")
print(df.shape)

print("\n========== DATA TYPES ==========")
print(df.dtypes)

print("\n========== MISSING VALUES ==========")
print(df.isnull().sum())

print("\n========== TARGET DISTRIBUTION ==========")
print(df["LoanStatus"].value_counts())


# ============================================================
# 3. DATA PREPROCESSING
# ============================================================

# Remove duplicate records
df = df.drop_duplicates()

# Fill missing numerical values
numeric_columns = df.select_dtypes(include=["int64", "float64"]).columns

for column in numeric_columns:
    df[column] = df[column].fillna(df[column].median())

# Fill missing categorical values
categorical_columns = df.select_dtypes(include=["object"]).columns

for column in categorical_columns:
    df[column] = df[column].fillna(df[column].mode()[0])


# ============================================================
# 4. ENCODE CATEGORICAL FEATURES
# ============================================================

label_encoders = {}

categorical_features = [
    "EmploymentStatus",
    "RepaymentHistory"
]

for column in categorical_features:

    encoder = LabelEncoder()

    df[column] = encoder.fit_transform(df[column])

    label_encoders[column] = encoder


# Encode target variable
target_encoder = LabelEncoder()

df["LoanStatus"] = target_encoder.fit_transform(df["LoanStatus"])


# ============================================================
# 5. FEATURE / TARGET SEPARATION
# ============================================================

X = df[
    [
        "Income",
        "CreditScore",
        "EmploymentStatus",
        "LoanAmount",
        "RepaymentHistory"
    ]
]

y = df["LoanStatus"]


# ============================================================
# 6. TRAIN / TEST SPLIT
# ============================================================

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.20,
    random_state=42,
    stratify=y
)

print("\n========== DATA SPLIT ==========")
print("Training samples:", len(X_train))
print("Testing samples :", len(X_test))


# ============================================================
# 7. DECISION TREE - GINI INDEX
# ============================================================

gini_model = DecisionTreeClassifier(
    criterion="gini",
    max_depth=5,
    min_samples_split=10,
    random_state=42
)

gini_model.fit(X_train, y_train)

gini_predictions = gini_model.predict(X_test)


# ============================================================
# 8. DECISION TREE - INFORMATION GAIN / ENTROPY
# ============================================================

entropy_model = DecisionTreeClassifier(
    criterion="entropy",
    max_depth=5,
    min_samples_split=10,
    random_state=42
)

entropy_model.fit(X_train, y_train)

entropy_predictions = entropy_model.predict(X_test)


# ============================================================
# 9. EVALUATION FUNCTION
# ============================================================

def evaluate_model(name, y_true, y_pred):

    accuracy = accuracy_score(y_true, y_pred)

    precision = precision_score(
        y_true,
        y_pred,
        zero_division=0
    )

    recall = recall_score(
        y_true,
        y_pred,
        zero_division=0
    )

    f1 = f1_score(
        y_true,
        y_pred,
        zero_division=0
    )

    print("\n===================================")
    print(name)
    print("===================================")

    print(f"Accuracy  : {accuracy:.4f}")
    print(f"Precision : {precision:.4f}")
    print(f"Recall    : {recall:.4f}")
    print(f"F1 Score  : {f1:.4f}")

    print("\nClassification Report:")
    print(
        classification_report(
            y_true,
            y_pred,
            target_names=target_encoder.classes_,
            zero_division=0
        )
    )

    return {
        "Model": name,
        "Accuracy": accuracy,
        "Precision": precision,
        "Recall": recall,
        "F1 Score": f1
    }


# ============================================================
# 10. EVALUATE BOTH MODELS
# ============================================================

gini_results = evaluate_model(
    "Decision Tree - Gini Index",
    y_test,
    gini_predictions
)

entropy_results = evaluate_model(
    "Decision Tree - Information Gain",
    y_test,
    entropy_predictions
)


# ============================================================
# 11. COMPARE MODELS
# ============================================================

results = pd.DataFrame([
    gini_results,
    entropy_results
])

print("\n========== MODEL COMPARISON ==========")
print(results)

results.to_csv(
    "model_comparison.csv",
    index=False
)


# ============================================================
# 12. MODEL COMPARISON GRAPH
# ============================================================

metrics = [
    "Accuracy",
    "Precision",
    "Recall",
    "F1 Score"
]

results_plot = results.set_index("Model")[metrics]

results_plot.plot(
    kind="bar",
    figsize=(10, 6)
)

plt.title("Decision Tree Performance Comparison")
plt.ylabel("Score")
plt.ylim(0, 1.05)
plt.xticks(rotation=0)
plt.legend(loc="lower right")
plt.tight_layout()

plt.savefig(
    "model_comparison.png",
    dpi=300
)

plt.show()


# ============================================================
# 13. CONFUSION MATRIX - BEST MODEL
# ============================================================

if gini_results["F1 Score"] >= entropy_results["F1 Score"]:

    best_model = gini_model
    best_predictions = gini_predictions
    best_model_name = "Gini Index"

else:

    best_model = entropy_model
    best_predictions = entropy_predictions
    best_model_name = "Information Gain / Entropy"


print("\n===================================")
print("BEST MODEL:", best_model_name)
print("===================================")


cm = confusion_matrix(
    y_test,
    best_predictions
)

plt.figure(figsize=(7, 5))

sns.heatmap(
    cm,
    annot=True,
    fmt="d",
    cmap="Blues",
    xticklabels=target_encoder.classes_,
    yticklabels=target_encoder.classes_
)

plt.title(
    f"Confusion Matrix - {best_model_name}"
)

plt.xlabel("Predicted")
plt.ylabel("Actual")

plt.tight_layout()

plt.savefig(
    "confusion_matrix.png",
    dpi=300
)

plt.show()


# ============================================================
# 14. FEATURE IMPORTANCE
# ============================================================

feature_importance = pd.DataFrame({
    "Feature": X.columns,
    "Importance": best_model.feature_importances_
})

feature_importance = feature_importance.sort_values(
    by="Importance",
    ascending=False
)

print("\n========== FEATURE IMPORTANCE ==========")
print(feature_importance)

feature_importance.to_csv(
    "feature_importance.csv",
    index=False
)


plt.figure(figsize=(9, 5))

sns.barplot(
    data=feature_importance,
    x="Importance",
    y="Feature"
)

plt.title(
    f"Feature Importance - {best_model_name}"
)

plt.tight_layout()

plt.savefig(
    "feature_importance.png",
    dpi=300
)

plt.show()


# ============================================================
# 15. DECISION TREE VISUALIZATION
# ============================================================

plt.figure(figsize=(20, 12))

plot_tree(
    best_model,
    feature_names=X.columns,
    class_names=target_encoder.classes_,
    filled=True,
    rounded=True,
    fontsize=10
)

plt.title(
    f"Loan Approval Decision Tree - {best_model_name}"
)

plt.savefig(
    "decision_tree.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()


# ============================================================
# 16. SAMPLE CUSTOMER PREDICTION
# ============================================================

sample_customer = pd.DataFrame({
    "Income": [75000],
    "CreditScore": [720],
    "EmploymentStatus": [
        label_encoders["EmploymentStatus"].transform(
            ["Employed"]
        )[0]
    ],
    "LoanAmount": [400000],
    "RepaymentHistory": [
        label_encoders["RepaymentHistory"].transform(
            ["Good"]
        )[0]
    ]
})


prediction = best_model.predict(sample_customer)

prediction_probability = best_model.predict_proba(
    sample_customer
)


predicted_status = target_encoder.inverse_transform(
    prediction
)[0]


print("\n===================================")
print("SAMPLE CUSTOMER PREDICTION")
print("===================================")

print("Income             : ₹75,000")
print("Credit Score       : 720")
print("Employment Status  : Employed")
print("Loan Amount        : ₹4,00,000")
print("Repayment History  : Good")

print("\nPredicted Loan Status:", predicted_status)

print(
    "Prediction Probability:",
    prediction_probability
)


# ============================================================
# 17. SAVE FINAL PREDICTIONS
# ============================================================

output = X_test.copy()

output["Actual"] = target_encoder.inverse_transform(
    y_test
)

output["Predicted"] = target_encoder.inverse_transform(
    best_predictions
)

output.to_csv(
    "loan_predictions.csv",
    index=False
)

print("\nAll results saved successfully.")

print("\nGenerated files:")
print("1. model_comparison.csv")
print("2. model_comparison.png")
print("3. confusion_matrix.png")
print("4. feature_importance.csv")
print("5. feature_importance.png")
print("6. decision_tree.png")
print("7. loan_predictions.csv")
