import 'package:eduquest247/jobs_posted.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class JobApplicationForm extends StatefulWidget {
  final String companyName;
  final String jobTitle;

  const JobApplicationForm({
    super.key,
    required this.companyName,
    required this.jobTitle,
  });

  @override
  State<JobApplicationForm> createState() => _JobApplicationFormState();
}

class _JobApplicationFormState extends State<JobApplicationForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
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
                style: GoogleFonts.poppins(
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
                maxLines: maxLines,
                style: GoogleFonts.poppins(
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
                        const BorderSide(color: Colors.black, width: 1.5),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                  contentPadding: const EdgeInsets.all(16),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? '${label} is required' : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const CircularProgressIndicator(),
            ),
          );
        },
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context); // Remove loading indicator

        Get.snackbar(
          'Success',
          'Job application submitted successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 16,
          duration: const Duration(seconds: 2),
        );

        // Navigate directly to jobs_posted page without allowing back navigation
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(
              () => JobsPostedPage(), // Changed to offAll with direct widget
              transition: Transition.fadeIn);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Job Application',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildFormSection('Personal Information', [
                  _buildTextField('Full Name', Icons.person_outline),
                  _buildTextField('Email Address', Icons.email_outlined),
                  _buildTextField('Phone Number', Icons.phone_outlined),
                ]),
                _buildDivider(),
                _buildFormSection('Professional Details', [
                  _buildTextField('Current Company', Icons.business_outlined),
                  _buildTextField('Years of Experience', Icons.work_outline),
                  _buildTextField('Skills & Expertise', Icons.star_outline),
                ]),
                _buildDivider(),
                _buildFormSection('Application Details', [
                  _buildTextField(
                    'Why are you interested in this position?',
                    Icons.description_outlined,
                    maxLines: 3,
                  ),
                ]),
                const SizedBox(height: 32),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.jobTitle} at ${widget.companyName}',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please fill in your details below',
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection(String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
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
          gradient: const LinearGradient(
            colors: [Colors.black87, Colors.black],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
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
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
