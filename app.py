from flask import Flask, jsonify, render_template, request, redirect, url_for, flash,session
import mysql.connector
import joblib
import pandas as pd
import os
import datetime


model = joblib.load(os.path.abspath('obesity_model_lgbm.pkl'))


# Create a Flask app
app = Flask(__name__)
app.secret_key = 'nutritionist'  # For flash messages


db_config= {
    'host': 'localhost',
    'user': 'root',  # Replace with your MySQL username
    'password': 'root@123',  # Replace with your MySQL password
    'database': 'Obesity'  # Second database
}

# Function to connect to a specific database
def get_db_connection():
    return mysql.connector.connect(**db_config)

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def handle_login():
    nutri_id = request.form['nutri_id']
    password = request.form['password']

    # Connect to the database
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Check if the user exists in the database
    cursor.execute("SELECT * FROM nutri_register WHERE nutri_id = %s AND password = %s", (nutri_id, password))
    user = cursor.fetchone()

    # Close the database connection
    cursor.close()
    conn.close()

    if user:
        # Store nutritionist information in session
        session['nutri_id'] = user['nutri_id']
        # session['user_role'] = user['user_role']  # If you need roles for permissions
        print("Session set for nutri_id:", session.get('nutri_id'))  # Debugging

        # Redirect to the nutritionist's homepage
        return redirect(url_for('homepage'))
    else:
        # Show error message for invalid login
        flash("Invalid login. Please try again.", "danger")
        return render_template('login.html')
    

@app.route('/forgot_password', methods=['GET', 'POST'])
def forgot_password():
    if request.method == 'POST':
        # Get the form data
        nutri_id = request.form['nutri_id']
        new_password = request.form['new_password']
        confirm_password = request.form['confirm_password']

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        try:
            # Check if the nutri_id exists
            cursor.execute("SELECT * FROM nutri_register WHERE nutri_id = %s", (nutri_id,))
            user = cursor.fetchone()

            if not user:
                # Nutritionist ID not found
                return render_template(
                    'forgot_password.html',
                    message="Your Nutritionist ID is not registered yet. Please register first.",
                    category="danger"
                )

            # Check if passwords match
            if new_password != confirm_password:
                return render_template(
                    'forgot_password.html',
                    message="Passwords do not match. Please try again.",
                    category="danger"
                )

            # Update the password
            cursor.execute(
                "UPDATE nutri_register SET password = %s WHERE nutri_id = %s",
                (new_password, nutri_id)
            )
            conn.commit()

            flash("Password updated successfully. Please log in.", "success")
            return redirect(url_for('login'))

        except Exception as e:
            flash(f"An error occurred: {e}", "danger")
        finally:
            cursor.close()
            conn.close()

    return render_template('forgot_password.html', message=None, category=None)

@app.route('/register')
def register():
    return render_template('register.html')

@app.route('/register', methods=['POST'])
def handle_register():
    nutri_id = request.form['nutri_id']
    password = request.form['password']
    name = request.form['name']
    phone_num = request.form['phone_num']
    mail_id = request.form['mail_id']
    gender = request.form['gender']
    user_role_id = request.form.get('user_role')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)


    try:
        # Insert new user into the database
        cursor.execute(
            """
            INSERT INTO nutri_register (nutri_id, password, user_role, name, phone_num, mail_id, gender)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            """,
            (nutri_id, password, user_role_id, name, phone_num, mail_id, gender)
        )
        conn.commit()
        flash('Registration successful! Please log in.', 'success')
        return redirect(url_for('login'))
    except mysql.connector.Error as err:
        flash(f'Error: {err}', 'danger')
        return redirect(url_for('register'))
    finally:
        cursor.close()
        conn.close()

@app.route('/homepage', methods=['GET', 'POST'])
def homepage():
    if 'nutri_id' in session:
        nutri_id = session['nutri_id']
        print("nutri_id in session during homepage route:", nutri_id)  # Debugging

        search_result = None  # Initialize search result
        if request.method == 'POST':
            patient_id = request.form['patient_id']
            try:
                
                # Connect to the database
                conn = get_db_connection()
                cursor = conn.cursor(dictionary=True)

                # Query to fetch patient details
                cursor.execute(
                    "SELECT patient_id, date_of_admission, name FROM patientprofile WHERE patient_id = %s",
                    (patient_id,)
                )
                search_result = cursor.fetchone()
                if not search_result:
                    flash("Patient not found!", "warning")
                conn.close()
            except Exception as e:
                flash(f"Error: {e}", "danger")

        return render_template('homepage.html', nutri_id=nutri_id, search_result=search_result)

    else:
        flash("Session expired. Please log in again.", "danger")
        return redirect(url_for('login'))

@app.route('/edit/<patient_id>', methods=['GET', 'POST'])
def edit_patient(patient_id):
    if request.method == 'POST':
        # Handle form submission to update patient data
        updated_data = request.form
        # Update the patientprofile table in the database
        query = """
            UPDATE patientprofile 
            SET name = %s, age = %s, sex = %s, date_of_admission = %s, date_of_discharge = %s,
                 medical_diagnosis = %s, lifestyle = %s
            WHERE patient_id = %s
        """
        values = (
            updated_data['name'], updated_data['age'], updated_data['sex'], updated_data['date_of_admission'], 
            updated_data['date_of_discharge'], 
            updated_data['medical_diagnosis'], updated_data['lifestyle'], patient_id
        )
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        # cursor = db.cursor()
        cursor.execute(query, values)
        conn.commit()
        flash('Patient details updated successfully!', 'success')
        return redirect(url_for('homepage'))
    else:
        # Fetch patient data for the given patient_id
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        # cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM patientprofile WHERE patient_id = %s", (patient_id,))
        patient_data = cursor.fetchone()
        return render_template('edit.html', patient_data=patient_data)

@app.route('/progress/<patient_id>')
def progress(patient_id):
    # Establish database connection
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Fetch required details from the report table for the given patient_id
        cursor.execute(
            """
            SELECT 
                date_of_evaluation, nutri_id, assessment_plan, dietitian_note
            FROM report
            WHERE patient_id = %s
            ORDER BY date_of_evaluation DESC
            """,
            (patient_id,)
        )
        results = cursor.fetchall()

        # Handle case where no data is found
        if not results:
            results = [{
                'date_of_evaluation': '-', 
                'nutri_id': '-', 
                'assessment_plan': '-', 
                'dietitian_note': '-'
            }]

    finally:
        cursor.close()
        conn.close()

    # Render the progress template with the results
    return render_template('progress.html', patient_id=patient_id, results=results)


@app.route('/obesity_predict/<patient_id>')
def obesity_predict(patient_id):
    # Retrieve nutri_id from session
    nutri_id = session.get('nutri_id')
    if not nutri_id:
        flash("Session expired. Please log in again.", "danger")
        return redirect(url_for('login'))

    try:
        # Fetch patient details from the database
        connection = get_db_connection()
        with connection.cursor(dictionary=True) as cursor:
            cursor.execute(
                "SELECT age, sex FROM patientprofile WHERE patient_id = %s", (patient_id,)
            )
            patient_details = cursor.fetchone()
        
        if not patient_details:
            flash(f"No patient found with ID: {patient_id}", "warning")
            return redirect(url_for('homepage'))

        # Retrieve gender and age
        age = patient_details.get('age', '')
        gender = patient_details.get('sex', '')

    except Exception as e:
        flash(f"Error retrieving patient details: {e}", "danger")
        return redirect(url_for('homepage'))
    finally:
        connection.close()

    return render_template(
        'obesity_predict.html',
        patient_id=patient_id,
        nutri_id=nutri_id,
        age=age,
        gender=gender,
    )

@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        # Retrieve data from the form
        doe = request.form['doe']
        patient_id = request.form['patient_id']
        nutri_id = session.get('nutri_id')
        gender = request.form['Gender']
        age = float(request.form['Age'])
        height = float(request.form['Height'])
        weight = float(request.form['Weight'])
        family_history = request.form['family_history_with_overweight']
        favc = request.form['FAVC']
        fcvc = int(request.form['FCVC'])
        ncp = float(request.form['NCP'])
        caec = request.form['CAEC']
        smoke = request.form['SMOKE']
        ch2o = float(request.form['CH2O'])
        scc = request.form['SCC']
        faf = float(request.form['FAF'])
        tue = float(request.form['TUE'])
        calc = request.form['CALC']
        mtrans = request.form['MTRANS']
        # Calculate BMI
        bmi = round(weight / (height ** 2), 2)

        # Prepare the input data
        input_data = pd.DataFrame([[
                gender, age, height, weight, family_history, favc, fcvc, ncp, caec, smoke, ch2o, scc, faf, tue, calc, mtrans
            ]], columns=[
                'Gender', 'Age', 'Height', 'Weight', 'family_history_with_overweight', 'FAVC', 'FCVC', 'NCP', 'CAEC', 
                'SMOKE', 'CH2O', 'SCC', 'FAF', 'TUE', 'CALC', 'MTRANS'
            ])
        input_data['id'] = 0

        # Make prediction
        prediction = model.predict(input_data)[0]

        # Prepare assessment plan
        assessment_plan = prediction

        # Insert data into report table
        # Assuming there's a function `insert_into_report` to handle the insertion
        re_id=insert_into_report(doe, patient_id, nutri_id, height, weight, bmi, smoke, calc, faf,
                           tue, ch2o, assessment_plan)

        # Redirect to the report page with prediction result
        return render_template('obesity_predict.html', prediction= prediction, patient_id=patient_id, re_id=re_id,  show_result=True)

    # Initial page load
    return render_template('obesity_predict.html', show_result=False)

def insert_into_report(doe, patient_id, nutri_id, height, weight, bmi, smoke, calc, faf,
                           tue, ch2o, assessment_plan):
    re_id = None
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Database insertion query
        query = f"""
        INSERT INTO report (
            patient_id, nutri_id, height, weight, bmi, smoking, alcohol, 
            physical_activity, time_using_technology, drinking_water_intake, assessment_plan, date_of_evaluation
        ) VALUES (
            '{patient_id}', '{nutri_id}', '{height}', '{weight}', '{bmi}', '{smoke}', '{calc}',
            '{faf}', '{tue}', {ch2o}, '{assessment_plan}', '{doe}'
        );
        """
        
        cursor.execute(query)
        re_id = cursor.lastrowid
        conn.commit()
        flash('Patient details saved successfully!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error: {err}', 'danger')
    finally:
        cursor.close()
        conn.close()
    if re_id is None:
        flash('Failed to save nutritional data due to an error.', 'danger')
        return redirect(url_for('error_page'))  # Replace with an actual error-handling page
    return re_id
@app.route('/update_dietitian_note', methods=['POST'])
def update_dietitian_note():
    re_id = request.form['re_id']
    dietitian_note = request.form['dietitian_note']
    
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    try:
        # Update query for the dietitian note
        query = """
        UPDATE report
        SET dietitian_note = %s
        WHERE re_id = %s
        """
        cursor.execute(query, (dietitian_note, re_id))
        conn.commit()
        flash('Dietitian note updated successfully!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error: {err}', 'danger')
    finally:
        cursor.close()
        conn.close()
    
    # Redirect back to the predict page or a confirmation page
    return redirect(url_for('report', re_id=re_id))

@app.route('/report')
def report():
    # Get re_id from the URL
    re_id = request.args.get('re_id')

    # Database query to fetch detailed report information based on re_id
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute(
            """
            SELECT 
                p.name, p.lifestyle, p.medical_diagnosis, 
                r.re_id, r.nutri_id, r.height, r.weight, r.bmi, 
                r.smoking, r.alcohol, r.physical_activity, r.time_using_technology, r.date_of_evaluation, r.dietitian_note,
                r.drinking_water_intake, r.assessment_plan
            FROM report r
            JOIN patientprofile p ON r.patient_id = p.patient_id
            WHERE r.re_id = %s
            """,
            (re_id,)
        )
        
        report_data = cursor.fetchone()  # Fetch the single matching row

    except mysql.connector.Error as err:
        flash(f'Error: {err}', 'danger')

    finally:
        cursor.close()
        conn.close()

    return render_template(
        'report.html',
        re_id=re_id,
        report_data=report_data
    )

@app.route('/logout')
def logout():
    session.pop('nutri_id', None)
    return redirect(url_for('login'))

@app.route('/patient_registration')
def patient_register():
    return render_template('patient_registration.html')

@app.route('/patient_registration', methods=['POST'])
def patient_registration():
    # Get form data
    patient_id = request.form['patient_id']
    name = request.form['name']
    age = request.form['age']
    sex = request.form['sex']
    date_of_admission = request.form['date_of_admission']
    date_of_discharge = request.form['date_of_discharge']
    medical_diagnosis = request.form['medical_diagnosis']
    lifestyle = request.form['lifestyle']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        # Insert patient details into the database
        cursor.execute(
            """
            INSERT INTO patientprofile (patient_id, name, age, sex, date_of_admission, date_of_discharge, medical_diagnosis, lifestyle)
            VALUES (%s,%s, %s, %s, %s, %s, %s, %s)
            """,
            (patient_id, name, age, sex, date_of_admission, date_of_discharge, medical_diagnosis, lifestyle)
        )
        conn.commit()
        flash('Patient details saved successfully!', 'success')
    except mysql.connector.Error as err:
        flash(f'Error: {err}', 'danger')
    finally:
        cursor.close()
        conn.close()

    # Redirect to homepage with a success message
    return redirect(url_for('homepage'))



if __name__ == "__main__":
    app.run(debug=True)
