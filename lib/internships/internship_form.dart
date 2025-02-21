import 'package:eduquest247/viewall_internships.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InternshipApplicationForm extends StatefulWidget {
  final String internshipType;

  const InternshipApplicationForm({
    super.key,
    required this.internshipType,
  });

  @override
  State<InternshipApplicationForm> createState() =>
      _InternshipApplicationFormState();
}

class _InternshipApplicationFormState extends State<InternshipApplicationForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController yearOfStudyController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController motivationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    collegeController.dispose();
    yearOfStudyController.dispose();
    skillsController.dispose();
    motivationController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {int maxLines = 1}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                label,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller,
                maxLines: maxLines,
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon(icon, color: Colors.black54, size: 22),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color.fromARGB(255, 254, 253, 253), width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: const EdgeInsets.all(8),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? '$label is required' : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String fullName = fullNameController.text.trim();
      final String email = emailController.text.trim();
      final String phone = phoneController.text.trim();
      final String college = collegeController.text.trim();
      final String yearOfStudy = yearOfStudyController.text.trim();
      final String skills = skillsController.text.trim();
      final String motivation = motivationController.text.trim();
      final String internshipType = widget.internshipType;

      final Uri apiUrl = Uri.parse('http://127.0.0.1:5000/api/internship-apply');

      try {
        final response = await http.post(
          apiUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'fullName': fullName,
            'email': email,
            'phone': phone,
            'college': college,
            'yearOfStudy': yearOfStudy,
            'skills': skills,
            'motivation': motivation,
            'internshipType': internshipType,
          }),
        );

        if (response.statusCode == 201) {
          Get.snackbar('Success', 'Internship application submitted successfully.',
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.off(() => ViewAllInternshipsPage());
        } else {
          final responseData = jsonDecode(response.body);
          Get.snackbar('Error', responseData['message'],
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to submit application: $e',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 135, 206, 235)], // Gradient background
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildFormSection('Personal Information', [
              _buildTextField('Full Name', Icons.person_outline, fullNameController),
              _buildTextField('Email Address', Icons.email_outlined, emailController),
              _buildTextField('Phone Number', Icons.phone_outlined, phoneController),
            ]),
            _buildFormSection('Academic Details', [
              _buildTextField('College/University', Icons.school_outlined, collegeController),
              _buildTextField('Current Year of Study', Icons.calendar_today_outlined, yearOfStudyController),
              _buildTextField('Skills & Expertise', Icons.star_outline, skillsController),
            ]),
            _buildFormSection('Application Details', [
              _buildTextField(
                'Why do you want to join this internship?',
                Icons.description_outlined,
                motivationController,
                maxLines: 3,
              ),
            ]),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 184, 227, 244), // Header box color
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'Apply for ${widget.internshipType} Internship',
        style: GoogleFonts.openSans(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0), // Header text color
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildFormSection(String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...fields,
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Container(
        height: 1,
        color: Colors.grey[200],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255), // Submit button color
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Submit Application',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Submit button text color
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.black, // Submit button icon color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
