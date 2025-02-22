from flask import Flask, jsonify, request
from flask_cors import CORS
import sqlite3  # Add this line

app = Flask(__name__)
CORS(app)

# Dummy databases
users = {}
loan_applications = []
internship_applications = []  # Ensure this line is present
job_applications = []  # Store job applications in memory
scholarship_applications = []  # Store scholarship applications in memory
college_enquiry_applications = []  # Store college enquiry applications in memory
hr_users = {"hr@company.com": "password123"}  # Example HR login
job_posts = []  # Store job posts in memory
notifications = []  # Store notifications in memory
user_profiles = {}  # Store user profiles by email
news_articles = []
@app.route('/api/news-articles', methods=['GET'])
def get_news_articles():
    articles = [
        {
            "title": "Azad Hind Diwas Celebration",
            "description": "Celebrating the spirit of Azad Hind Diwas and its historical significance.",
            "image": "https://static.toiimg.com/photo/118463088.cms",
            "url": "https://www.linkedin.com/posts/ambalikabhat_azadhinddiwas-activity-7298726492891422720-Rx7G?utm_source=share&utm_medium=member_desktop&rcm=ACoAAFWy7sYBwGYWCK1MllCIZQfgF8kfrKUa9uk"
        }
    ]
    return jsonify({"status": "Success", "articles": articles}), 200

# Get News Articles Endpoint


# Home Route
@app.route('/')
def home():
    return jsonify({"message": "Flask Backend Connected Successfully!"})

# Signup Endpoint
@app.route('/api/signup', methods=['POST'])
def signup():
    data = request.json
    phone = data.get('phone')
    password = data.get('password')

    if not phone or not password:
        return jsonify({"status": "Failed", "message": "Phone and password are required"}), 400

    if phone in users:
        return jsonify({"status": "Failed", "message": "Phone number already registered"}), 409

    # Store user with phone as the key
    users[phone] = {"password": password}
    return jsonify({"status": "Success", "message": "Account created successfully"}), 201

# Login Endpoint
@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    phone = data.get('phone')
    password = data.get('password')

    user = users.get(phone)
    if user and user['password'] == password:
        return jsonify({"status": "Success", "message": "Login successful"}), 200
    return jsonify({"status": "Failed", "message": "Invalid credentials"}), 401

# Loan Application Endpoint
@app.route('/api/loan-apply', methods=['POST'])
def apply_loan():
    data = request.json
    full_name = data.get('fullName')
    email = data.get('email')
    phone = data.get('phone')
    amount = data.get('amount')
    bank_name = data.get('bankName')

    if not all([full_name, email, phone, amount, bank_name]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    application = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "amount": amount,
        "bank_name": bank_name
    }

    loan_applications.append(application)
    return jsonify({"status": "Success", "message": "Loan application submitted successfully"}), 201

# Get All Loan Applications
@app.route('/api/loan-applications', methods=['GET'])
def get_loan_applications():
    return jsonify({"status": "Success", "applications": loan_applications}), 200

@app.route('/api/users', methods=['GET'])
def get_users():
    return jsonify(users), 200

# Internship Application Endpoint
@app.route('/api/internship-apply', methods=['POST'])
def apply_internship():
    data = request.json
    full_name = data.get('fullName')
    email = data.get('email')
    phone = data.get('phone')
    college = data.get('college')
    year_of_study = data.get('yearOfStudy')
    skills = data.get('skills')
    motivation = data.get('motivation')
    internship_type = data.get('internshipType')

    if not all([full_name, email, phone, college, year_of_study, skills, motivation, internship_type]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    # Store in memory like loan_applications
    application = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "college": college,
        "year_of_study": year_of_study,
        "skills": skills,
        "motivation": motivation,
        "internship_type": internship_type
    }

    internship_applications.append(application)

    return jsonify({"status": "Success", "message": "Internship application submitted successfully"}), 201

# Endpoint to view all internship applications
@app.route('/api/internship-applications', methods=['GET'])
def get_internship_applications():
    return jsonify({"status": "Success", "applications": internship_applications}), 200

# Job Application Endpoint
@app.route('/api/job-apply', methods=['POST'])
def apply_job():
    data = request.json
    full_name = data.get('fullName')
    email = data.get('email')
    phone = data.get('phone')
    experience = data.get('experience')
    job_title = data.get('jobTitle')
    company = data.get('company')
    salary = data.get('salary')
    mode = data.get('mode')

    if not all([full_name, email, phone, experience, job_title, company, salary, mode]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    application = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "experience": experience,
        "job_title": job_title,
        "company": company,
        "salary": salary,
        "mode": mode
    }

    job_applications.append(application)

    return jsonify({"status": "Success", "message": "Job application submitted successfully"}), 201
# Get All Job Applications
@app.route('/api/job-applications', methods=['GET'])
def get_job_applications():
    return jsonify({"status": "Success", "applications": job_applications}), 200
# Scholarship Application Endpoint
@app.route('/api/scholarship-apply', methods=['POST'])
def apply_scholarship():
    data = request.json
    full_name = data.get('fullName')
    email = data.get('email')
    phone = data.get('phone')
    qualification = data.get('qualification')
    course = data.get('course')

    if not all([full_name, email, phone, qualification, course]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    application = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "qualification": qualification,
        "course": course
    }

    scholarship_applications.append(application)

    return jsonify({"status": "Success", "message": "Scholarship application submitted successfully"}), 201
# Get All Scholarship Applications
@app.route('/api/scholarship-applications', methods=['GET'])
def get_scholarship_applications():
    return jsonify({"status": "Success", "applications": scholarship_applications}), 200

# College Admission Enquiry Endpoint
@app.route('/api/college-enquiry', methods=['POST'])
def apply_college_enquiry():
    data = request.json
    full_name = data.get('fullName')
    email = data.get('email')
    phone = data.get('phone')
    degree = data.get('degree')
    message = data.get('message')
    college_name = data.get('collegeName')

    if not all([full_name, email, phone, degree, message, college_name]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    application = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "degree": degree,
        "message": message,
        "college_name": college_name
    }

    college_enquiry_applications.append(application)

    return jsonify({"status": "Success", "message": "College admission enquiry submitted successfully"}), 201
# Get All College Enquiry Applications
@app.route('/api/college-enquiry-applications', methods=['GET'])
def get_college_enquiry_applications():
    return jsonify({"status": "Success", "applications": college_enquiry_applications}), 200

# HR Login Endpoint
@app.route('/api/hr-login', methods=['POST'])
def hr_login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    if not all([email, password]):
        return jsonify({"status": "Failed", "message": "Email and password are required"}), 400

    if email in hr_users and hr_users[email] == password:
        return jsonify({"status": "Success", "message": "HR login successful"}), 200

    return jsonify({"status": "Failed", "message": "Invalid HR credentials"}), 401
# Job Post Endpoint
@app.route('/api/job-post', methods=['POST'])
def post_job():
    data = request.json
    company_name = data.get('companyName')
    job_title = data.get('jobTitle')
    location = data.get('location')
    salary_range = data.get('salaryRange')
    experience = data.get('experience')
    description = data.get('description')
    requirements = data.get('requirements')

    if not all([company_name, job_title, location, salary_range, experience, description, requirements]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    job = {
        "company_name": company_name,
        "job_title": job_title,
        "location": location,
        "salary_range": salary_range,
        "experience": experience,
        "description": description,
        "requirements": requirements
    }

    job_posts.append(job)

    return jsonify({"status": "Success", "message": "Job posted successfully"}), 201
# Get All Job Posts
@app.route('/api/job-posts', methods=['GET'])
def get_job_posts():
    return jsonify({"status": "Success", "job_posts": job_posts}), 200

# Push Notification Endpoint
@app.route('/api/push-notification', methods=['POST'])
def push_notification():
    data = request.json
    title = data.get('title')
    message = data.get('message')
    category = data.get('category')  # e.g., Priority, New, Regular

    if not all([title, message, category]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    notification = {
        "title": title,
        "message": message,
        "category": category,
        "timestamp": "Just now"
    }

    notifications.append(notification)

    return jsonify({"status": "Success", "message": "Notification pushed successfully"}), 201
# Get All Notifications
@app.route('/api/notifications', methods=['GET'])
def get_notifications():
    return jsonify({"status": "Success", "notifications": notifications}), 200

# Update Personal Information Endpoint
@app.route('/api/update-profile', methods=['POST'])
def update_profile():
    data = request.json
    full_name = data.get('fullName')
    email = data.get('email')
    phone = data.get('phone')
    college = data.get('college')
    degree = data.get('degree')

    if not all([full_name, email, phone, college, degree]):
        return jsonify({"status": "Failed", "message": "All fields are required"}), 400

    # Store user profile by email
    user_profiles[email] = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "college": college,
        "degree": degree
    }

    return jsonify({"status": "Success", "message": "Profile updated successfully"}), 200
# Get All User Profiles
@app.route('/api/user-profiles', methods=['GET'])
def get_user_profiles():
    return jsonify({"status": "Success", "profiles": list(user_profiles.values())}), 200

if __name__ == '__main__':
    app.run(debug=True)
