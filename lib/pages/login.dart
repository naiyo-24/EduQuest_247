import 'package:eduquest247/pages/forget_password.dart';
import 'package:eduquest247/route/route_generator.dart';
import 'package:eduquest247/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _handleLogin() {
    // Add login validation here if needed
    Get.offNamed('/home'); // Changed to use offNamed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 135, 206, 235),
              Colors.white,
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontFamily: 'Jaldi',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Changed to black
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Login to continue your learning journey',
                      style: TextStyle(
                        fontFamily: 'Jaldi',
                        fontSize: 16,
                        color: Colors.black, // Changed to black
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Changed to white
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTextField(
                              'Email or Phone', Icons.email_outlined),
                          const SizedBox(height: 12),
                          _buildTextField('Password', Icons.lock_outline,
                              obscureText: true),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => const ForgetPasswordPage(),
                                    transition: Transition.rightToLeft);
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.black), // Changed to black
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _handleLogin,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Changed to black
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() =>
                                  const SignUpPage()); // Changed from Navigator.pushNamed
                            },
                            child: const Text(
                              'Do not have an account? Sign Up',
                              style: TextStyle(
                                  color: Colors.black), // Changed to black
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Or connect with us through',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black), // Changed to black
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _socialButton(Icons.facebook, const Color.fromARGB(255, 1, 1, 1), () {}),
                              const SizedBox(width: 20),
                              _socialButton(
                                  Icons.g_mobiledata,
                                  const Color.fromARGB(255, 0, 0, 0),
                                  () {}),
                                const SizedBox(width: 20),
                              _socialButton(
                                  Icons.insert_photo_rounded,
                                  const Color.fromARGB(255, 0, 0, 0),
                                  () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black), // Changed to black
        prefixIcon: Icon(icon, color: Colors.black), // Changed to black
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black), // Changed to black
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white, // Changed to white
      ),
      style: const TextStyle(color: Colors.black), // Changed to black
    );
  }

  Widget _socialButton(IconData icon, Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Changed to white
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color),
        iconSize: 32,
      ),
    );
  }
}
