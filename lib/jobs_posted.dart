import 'dart:ui';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eduquest247/components/floating_nav_button.dart'; // Add this import
import 'package:eduquest247/components/standard_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobsPostedPage extends StatelessWidget {
  final List<Map<String, String>> jobsPosted = [
    {
      "title": "Software Developer",
      "company": "Tech Innovators",
      "salary": "\$60,000 - \$80,000",
      "mode": "Hybrid"
    },
    {
      "title": "Data Scientist",
      "company": "Data Analytics Corp",
      "salary": "\$70,000 - \$90,000",
      "mode": "Remote"
    },
    {
      "title": "Project Manager",
      "company": "Global Solutions",
      "salary": "\$75,000 - \$95,000",
      "mode": "On-site"
    },
    {
      "title": "UI/UX Designer",
      "company": "Creative Minds",
      "salary": "\$55,000 - \$75,000",
      "mode": "Hybrid"
    },
    {
      "title": "DevOps Engineer",
      "company": "Cloud Systems Inc",
      "salary": "\$80,000 - \$100,000",
      "mode": "Remote"
    },
  ];

  JobsPostedPage({super.key});

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
                          'Available Job Positions',
                          style: GoogleFonts.openSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: jobsPosted.length,
                          itemBuilder: (context, index) {
                            final job = jobsPosted[index];
                            return _buildJobBox(
                              job["title"]!,
                              job["company"]!,
                              job["salary"]!,
                              job["mode"]!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const FloatingNavButton(currentIndex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildJobBox(
      String title, String company, String salary, String mode) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.dialog(JobApplyDialog(
            jobTitle: title,
            company: company,
            salary: salary,
            mode: mode,
          )),
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
                          title,
                          style: GoogleFonts.openSans(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$company | $salary | $mode',
                          style: GoogleFonts.openSans(
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

class JobApplyDialog extends StatefulWidget {
  final String jobTitle;
  final String company;
  final String salary;
  final String mode;

  const JobApplyDialog({
    required this.jobTitle,
    required this.company,
    required this.salary,
    required this.mode,
    Key? key,
  }) : super(key: key);

  @override
  _JobApplyDialogState createState() => _JobApplyDialogState();
}

class _JobApplyDialogState extends State<JobApplyDialog> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  Future<void> _submitJobApplication() async {
    final String fullName = fullNameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String experience = experienceController.text.trim();

    if (fullName.isEmpty || email.isEmpty || phone.isEmpty || experience.isEmpty) {
      Get.snackbar('Error', 'All fields are required.',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final Uri apiUrl = Uri.parse('http://127.0.0.1:5000/api/job-apply');

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'experience': experience,
          'jobTitle': widget.jobTitle,
          'company': widget.company,
          'salary': widget.salary,
          'mode': widget.mode,
        }),
      );

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar('Success', 'Job application submitted successfully.',
            backgroundColor: Colors.green, colorText: Colors.white);
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
                  'Apply for Position',
                  style: GoogleFonts.openSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1872db),
                  ),
                ),
                Text(
                  widget.jobTitle,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Color.fromARGB(255, 91, 166, 252),
                  ),
                ),
                const SizedBox(height: 32),
                _buildStylishTextField('Full Name', Icons.person, fullNameController),
                _buildStylishTextField('Email Address', Icons.email, emailController),
                _buildStylishTextField('Phone Number', Icons.phone, phoneController),
                _buildStylishTextField('Experience (Years)', Icons.work, experienceController),
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
                        onPressed: _submitJobApplication,
                        backgroundColor: Color(0xFF1872db),
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
      {required VoidCallback onPressed, bool isOutlined = false, required Color backgroundColor}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined ? Colors.white : backgroundColor,
        foregroundColor: isOutlined ? Colors.red : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isOutlined ? const BorderSide(color: Color.fromARGB(255, 219, 27, 24)) : BorderSide.none,
        ),
        elevation: isOutlined ? 0 : 2,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  Widget _buildStylishTextField(String label, IconData icon, TextEditingController controller) {
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
        controller: controller,
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
