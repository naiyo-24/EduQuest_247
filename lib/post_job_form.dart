import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'jobs_posted.dart';

class PostJobFormPage extends StatefulWidget {
  const PostJobFormPage({super.key});

  @override
  PostJobFormPageState createState() => PostJobFormPageState();
}

class PostJobFormPageState extends State<PostJobFormPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _postRequiredController = TextEditingController();
  final _salaryRangeController = TextEditingController();
  final _companyDetailsController = TextEditingController();
  final _postDetailsController = TextEditingController();
  final _officeTimingsController = TextEditingController();
  String _mode = 'Remote';

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
    _companyNameController.dispose();
    _postRequiredController.dispose();
    _salaryRangeController.dispose();
    _companyDetailsController.dispose();
    _postDetailsController.dispose();
    _officeTimingsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show success notification
      Get.snackbar(
        'Success',
        'Job posted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF6A0DAD),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        ),
        boxShadows: [
          BoxShadow(
            color: const Color(0xFF6A0DAD).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

      // Wait for 1 second before navigating
      Future.delayed(const Duration(seconds: 1), () {
        Get.to(() => JobsPostedPage(), 
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      });
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {IconData? icon}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6A0DAD).withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          style: GoogleFonts.openSans(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(
              icon,
              color: const Color(0xFF6A0DAD).withOpacity(0.7),
            ) : null,
            labelText: label,
            labelStyle: GoogleFonts.openSans(
              color: Colors.grey[600],
              fontSize: 14,
            ),
            floatingLabelStyle: GoogleFonts.openSans(
              color: const Color(0xFF6A0DAD),
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xFF6A0DAD),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(24),
          ),
          validator: (value) => value?.isEmpty ?? true ? 'Please enter $label' : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Create New Job Post',
          style: GoogleFonts.openSans(
            color: const Color(0xFF6A0DAD),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6A0DAD)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[50]!,
              Colors.white,
              Colors.grey[50]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Details',
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6A0DAD),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(_companyNameController, 'Company Name', icon: Icons.business),
                  _buildTextField(_postRequiredController, 'Position', icon: Icons.work),
                  _buildTextField(_salaryRangeController, 'Salary Range', icon: Icons.attach_money),
                  _buildTextField(_companyDetailsController, 'Company Details', icon: Icons.info_outline),
                  _buildTextField(_postDetailsController, 'Job Description', icon: Icons.description),
                  _buildTextField(_officeTimingsController, 'Working Hours', icon: Icons.access_time),
                  
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6A0DAD).withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _mode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: const Color(0xFF6A0DAD).withOpacity(0.7),
                          ),
                          labelText: 'Work Mode',
                          labelStyle: GoogleFonts.openSans(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.all(24),
                        ),
                        items: ['Remote', 'In-house', 'Hybrid'].map((mode) => DropdownMenuItem(
                          value: mode,
                          child: Text(mode, style: GoogleFonts.openSans()),
                        )).toList(),
                        onChanged: (value) => setState(() => _mode = value!),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6A0DAD), Color(0xFF9747FF)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6A0DAD).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.send_rounded),
                        label: Text(
                          'Post Job',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      ),
                    ),
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
