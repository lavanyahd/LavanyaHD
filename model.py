import pandas as pd
from sklearn.model_selection import train_test_split, RandomizedSearchCV
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from lightgbm import LGBMClassifier
from sklearn.metrics import classification_report
import joblib
from flask import Flask, request, jsonify

# Flask App
app = Flask(__name__)

# Load dataset
train_data = pd.read_csv("train.csv")

# Define features (X) and target (y)
X = train_data.drop('NObeyesdad', axis=1)
y = train_data['NObeyesdad']

# Split the data into training and validation sets
X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2, random_state=42)

# Define the column transformer
numeric_features = X.select_dtypes(include=['float64', 'int64']).columns
categorical_features = X.select_dtypes(include=['object']).columns

preprocessor = ColumnTransformer(
    transformers=[
        ('num', StandardScaler(), numeric_features),
        ('cat', OneHotEncoder(handle_unknown='ignore'), categorical_features)
    ]
)

# Create a pipeline with preprocessing and model
pipeline = Pipeline(steps=[
    ('preprocessor', preprocessor),
    ('classifier', LGBMClassifier(random_state=42))
])

# Define hyperparameters for RandomizedSearchCV
param_dist = {
    'classifier__n_estimators': [100, 200, 300],
    'classifier__learning_rate': [0.01, 0.05, 0.1],
    'classifier__max_depth': [3, 5, 7, 10],
    'classifier__num_leaves': [31, 50, 70],
}

# Use RandomizedSearchCV for hyperparameter tuning
random_search = RandomizedSearchCV(pipeline, param_distributions=param_dist, n_iter=10, cv=5, random_state=42)
random_search.fit(X_train, y_train)

# Get the best model
best_model = random_search.best_estimator_

# Save the trained model
joblib.dump(best_model, 'obesity_model_lgbm.pkl')

# Evaluate the model
y_pred = best_model.predict(X_val)
print(classification_report(y_val, y_pred))

# Flask API for Prediction
def preprocess_input(input_data, pipeline):
    """
    Preprocess the input data to match the format of the training data.
    Args:
    - input_data (dict or DataFrame): Input data for prediction.
    - pipeline: Trained pipeline containing preprocessing and the model.
    
    Returns:
    - Preprocessed input ready for prediction.
    """
    # Convert input to DataFrame if needed
    if isinstance(input_data, dict):
        input_data = pd.DataFrame([input_data])
    
    # Check for missing columns
    expected_columns = pipeline.named_steps['preprocessor'].transformers_[0][2] + \
                       list(pipeline.named_steps['preprocessor'].transformers_[1][2])
    for col in expected_columns:
        if col not in input_data.columns:
            raise ValueError(f"Missing required column: {col}")
    
    # Handle missing values
    input_data = input_data.fillna(0)  # Replace NaN with 0 or an appropriate value
    
    return input_data

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Parse input data
        input_data = request.json  # Assuming JSON input
        preprocessed_input = preprocess_input(input_data, best_model)  # Preprocess input
        
        # Perform prediction
        prediction = best_model.predict(preprocessed_input)
        result = prediction[0]  # Assuming a single prediction

        return jsonify({"prediction": result}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)
