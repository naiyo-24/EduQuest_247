import 'dart:ui';
import 'package:eduquest247/components/app_bar_dropdown.dart';
import 'package:eduquest247/components/floating_nav_button.dart';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:eduquest247/components/standard_app_bar.dart';

class ScholarshipPage extends StatefulWidget {
  const ScholarshipPage({super.key});

  @override
  State<ScholarshipPage> createState() => _ScholarshipPageState();
}

class _ScholarshipPageState extends State<ScholarshipPage>
    with SingleTickerProviderStateMixin {
  final double appBarHeight = 56.0; // Standard AppBar height
  late AnimationController _controller;
  bool _isLoading = true;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Single form key for the entire widget

  // Add form controllers at class level
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final qualificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // Simulate loading
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    qualificationController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> scholarships = [
    {
      'course': 'B.Tech',
      'amount': 'Up to ₹2,50,000',
      'eligibility': 'Merit-based, 80% in 12th',
      'deadline': 'August 30, 2024',
    },
    {
      'course': 'BCA',
      'amount': 'Up to ₹1,50,000',
      'eligibility': 'Merit-based, 75% in 12th',
      'deadline': 'July 30, 2024',
    },
    {
      'course': 'MBA',
      'amount': 'Up to ₹3,00,000',
      'eligibility': 'CAT/MAT score',
      'deadline': 'September 15, 2024',
    },
    // Add more scholarships here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(color: Color.fromARGB(255, 255, 255, 255),),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
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
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 135, 206, 235),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  "Empowering Dreams: Discover Life-Changing Scholarship Opportunities",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    height: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: _isLoading
                    ? _buildLoadingIndicator()
                    : _buildScholarshipsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }

  Widget _buildScholarshipsList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      itemCount: scholarships.length,
      itemBuilder: (context, index) {
        final scholarship = scholarships[index];
        return Hero(
          tag: 'scholarship_$index',
          child: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.white, // Changed to white
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 201, 198, 202).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${scholarship['course']} Scholarship',
                            style: GoogleFonts.openSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 135, 206, 235),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.school,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildScholarshipInfo('Amount', scholarship['amount']!,
                          Icons.currency_rupee),
                      _buildScholarshipInfo('Eligibility',
                          scholarship['eligibility']!, Icons.verified_user),
                      _buildScholarshipInfo('Deadline',
                          scholarship['deadline']!, Icons.calendar_today),
                      const SizedBox(height: 20),
                      _buildApplyButton(context, scholarship, index),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScholarshipInfo(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: const Color.fromARGB(179, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton(
      BuildContext context, Map<String, dynamic> scholarship, int index) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 135, 206, 235), // Changed to sky blue
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 254, 254).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _showApplicationForm(context, scholarship['course']),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 135, 206, 235), // Changed to sky blue
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Apply Now',
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black, // Changed to black
          ),
        ),
      ),
    );
  }

  void _showApplicationForm(BuildContext context, String course) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                      'Apply for Scholarship',
                      style: GoogleFonts.openSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1872db),
                      ),
                    ),
                    Text(
                      course,
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: Color.fromARGB(255, 91, 166, 252),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildStylishTextField('Full Name', Icons.person),
                    _buildStylishTextField('Email Address', Icons.email),
                    _buildStylishTextField('Phone Number', Icons.phone),
                    _buildStylishTextField('Qualification', Icons.school),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDialogButton(
                            'Cancel',
                            onPressed: () => Navigator.pop(context),
                            isOutlined: true,
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
                                'Scholarship application submitted successfully',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Color.fromARGB(255, 135, 206, 235),
                                colorText: const Color.fromARGB(255, 255, 255, 255),
                                margin: const EdgeInsets.all(16),
                                borderRadius: 16,
                                duration: const Duration(seconds: 3),
                                icon: const Icon(Icons.check_circle,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              );
                            }, backgroundColor: Color(0xFF1872db),
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
      },
    );
  }

  Widget _buildDialogButton(String text,
      {required VoidCallback onPressed, bool isOutlined = false, required Color backgroundColor}) {
    return ElevatedButton(
      onPressed: () {
        if (!isOutlined) {
          // This is the submit button
          Get.back(); // Close the dialog
          Get.snackbar(
            'Success!',
            'Scholarship application submitted successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color(0xFF1872db),
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
            isOutlined ? Colors.white : const Color(0xFF1872db),
        foregroundColor:
            isOutlined ? Colors.red : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isOutlined
              ? const BorderSide(color: Color.fromARGB(255, 219, 27, 24))
              : BorderSide.none,
        ),
        elevation: isOutlined ? 0 : 2,
      ),
      child: Text(
        text,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: 18,
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
          prefixIcon: Icon(icon, color: const Color(0xFF1872db)),
          labelText: label,
          labelStyle: GoogleFonts.openSans(color: Colors.grey[600]),
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
