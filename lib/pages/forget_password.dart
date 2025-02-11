import 'package:eduquest247/route/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduquest247/pages/login.dart';
import 'package:eduquest247/pages/reset_password.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _sendOTP() {
    if (_emailController.text.isNotEmpty) {
      setState(() {
        _otpSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent to your email'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _verifyOTP() {
    if (_otpController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP verified successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(
        const Duration(seconds: 1),
        () => Get.to(() => const ResetPasswordPage(),
            transition: Transition.fadeIn),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
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
          child: Row(
            children: [
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back Button Row
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                    // Main Content Column
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reset Password',
                            style: TextStyle(
                              fontFamily: 'Jaldi',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Enter your email address to receive OTP',
                            style: TextStyle(
                              fontFamily: 'Jaldi',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    prefixIcon: const Icon(Icons.email_outlined,
                                        color: Colors.black),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: _sendOTP,
                                    child: const Text(
                                      'Send OTP',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                if (_otpSent) ...[
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: _otpController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 6,
                                    decoration: InputDecoration(
                                      labelText: 'Enter OTP',
                                      labelStyle: const TextStyle(
                                          color: Colors.black),
                                      prefixIcon: const Icon(Icons.lock_outline,
                                          color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 45,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: _verifyOTP,
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
