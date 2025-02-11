import 'dart:ui';

import 'package:eduquest247/components/floating_nav_button.dart';

import 'package:eduquest247/components/app_bar_dropdown.dart';

import 'package:eduquest247/components/floating_nav_button.dart';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:eduquest247/all_colleges.dart';
import 'package:eduquest247/my_account.dart';
import 'package:eduquest247/notifications.dart';
import 'package:eduquest247/scholarships/scholarship.dart';
import 'package:eduquest247/components/standard_app_bar.dart';

// Main function to run the app
void main() {
  runApp(EduQuestApp());
}

// Main app widget
class EduQuestApp extends StatelessWidget {
  const EduQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loans',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 251, 251, 251),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
      ),
      home: LoanPage(),
    );
  }
}

class LoanPage extends StatelessWidget {
  final List<Map<String, String>> loanOptions = [
    {
      "bankName": "State Bank Of India",
      "interestRate": "7.5%",
      "amount": "₹10,00,000"
    },
    {
      "bankName": "Bank Of Baroda",
      "interestRate": "8.0%",
      "amount": "₹15,00,000"
    },
    {
      "bankName": "HDFC Bank",
      "interestRate": "8.5%",
      "amount": "₹20,00,000"
    },
    {
      "bankName": "Kotak Mahindra",
      "interestRate": "9.0%",
      "amount": "₹25,00,000"
    },
    {
      "bankName": "Axis Bank",
      "interestRate": "9.5%",
      "amount": "₹30,00,000"
    },
  ];

  LoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
          () => HomeScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300),
        );
        return false;
      },
      child: Scaffold(
        appBar: const StandardAppBar(color: Color.fromARGB(252, 249, 249, 249),),
        backgroundColor: const Color.fromARGB(255, 135, 206, 235), // Sky blue color
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color.fromARGB(255, 135, 206, 235),
                      Color.fromARGB(255, 135, 206, 235), // Sky blue color
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 6, bottom: 12),
                        child: Text(
                          'Available Loan Options',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: loanOptions.length,
                          itemBuilder: (context, index) {
                            final loan = loanOptions[index];
                            return _buildLoanBox(
                              loan["bankName"]!,
                              loan["interestRate"]!,
                              loan["amount"]!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const FloatingNavButton(currentIndex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanBox(String bankName, String interestRate, String amount) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.dialog(ApplyFormDialog(bankName: bankName)),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bankName,
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Interest: $interestRate | Amount: Up to $amount',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ApplyFormDialog extends StatelessWidget {
  final String bankName;

  const ApplyFormDialog({super.key, required this.bankName});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Apply for Loan',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  bankName,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                _buildStylishTextField('Full Name', Icons.person),
                _buildStylishTextField('Email Address', Icons.email),
                _buildStylishTextField('Phone Number', Icons.phone),
                _buildStylishTextField('Desired Loan Amount', Icons.currency_rupee),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _buildDialogButton(
                        'Cancel',
                        onPressed: () => Navigator.pop(context),
                        isOutlined: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDialogButton(
                        'Submit',
                        onPressed: () {
                          Get.back();
                          Get.snackbar(
                            'Success!',
                            'Loan application submitted successfully',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Color.fromARGB(255, 135, 206, 235),
                            colorText: const Color.fromARGB(255, 0, 0, 0),
                            margin: const EdgeInsets.all(16),
                            borderRadius: 16,
                            duration: const Duration(seconds: 3),
                            icon: const Icon(Icons.check_circle,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogButton(String text,
      {required VoidCallback onPressed, bool isOutlined = false}) {
    return ElevatedButton(
      onPressed: () {
        if (!isOutlined) {
          // This is the submit button
          Get.back(); // Close the dialog
          Get.snackbar(
            'Success!',
            'Loan application submitted successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.black,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16),
            borderRadius: 16,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.check_circle, color: Colors.white),
          );
        } else {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isOutlined ? Colors.white : const Color.fromARGB(255, 0, 0, 0),
        foregroundColor:
            isOutlined ? const Color.fromARGB(255, 0, 0, 0) : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isOutlined
              ? const BorderSide(color: Color.fromARGB(255, 1, 0, 1))
              : BorderSide.none,
        ),
        elevation: isOutlined ? 0 : 2,
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildStylishTextField(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color.fromARGB(255, 135, 206, 235)),
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
