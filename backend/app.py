from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# Dummy database for users (using phone number as key)
users = {}

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

if __name__ == '__main__':
    app.run(debug=True)
