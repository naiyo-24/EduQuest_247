import 'package:get/get.dart';

import 'menu_bar.dart'; // Import MenuBar
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class CustomStaticAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomStaticAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromARGB(255, 135, 206, 235),
              Color.fromARGB(255, 135, 206, 235),
            ],
          ),
        ),
      ),
      title: Text(title, style: GoogleFonts.openSans(color: Colors.black)),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight * 0.8;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: CustomStaticAppBar(
        title: 'My Account',
        actions: [
          _buildActionIcon(
            Icons.settings,
            () => Get.to(() => const SettingsPage()),
            color: Colors.black,
          ),
          const SizedBox(width: 2),
        ],
      ),
      body: Container(
        height: availableHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color.fromARGB(255, 135, 206, 235),
              Color.fromARGB(255, 135, 206, 235),
            ],
          ),
        ),
        child: ListView(
          children: [
            // Profile Picture Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 135, 206, 235),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/profile.jpeg'),
                        backgroundColor: Colors.transparent,
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Color.fromARGB(255, 14, 77, 150)),
                        onPressed: () {
                          // Handle profile picture edit
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rajdeep Dey', // Replace with actual user name
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'deyrajdeep201@gmail.com', // Replace with actual user email
                    style: GoogleFonts.openSans(
                      color: Colors.grey[800],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 135, 206, 235),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileOption(
                    options: {
                      'icon': Icons.person_outline,
                      'title': 'Personal Information',
                      'subtitle': 'Update your personal details',
                      'onTap': () => Get.to(() => const PersonalInfoForm()),
                    },
                  ),
                  _buildProfileOption(
                    options: {
                      'icon': Icons.update_rounded,
                      'title': 'Updates & Notifications',
                      'subtitle': 'Track Your Applications',
                      'onTap': () {},
                    },
                  ),
                  _buildProfileOption(
                    options: {
                      'icon': Icons.file_copy_rounded,
                      'title': 'My Documents',
                      'subtitle': 'Upload and Edit your documents',
                      'onTap': () {},
                      'color': Color.fromARGB(255, 14, 77, 150),
                    },
                  ),
                  _buildProfileOption(
                    options: {
                      'icon': Icons.help_outline,
                      'title': 'Help Center',
                      'subtitle': 'FAQ and support',
                      'onTap': () {},
                    },
                  ),
                  _buildProfileOption(
                    options: {
                      'icon': Icons.logout,
                      'title': 'Log Out',
                      'subtitle': 'Sign out of your account',
                      'onTap': () => Navigator.pushNamed(context, '/login'),
                      'isDestructive': true,
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
  
    );
  }

  Widget _buildProfileOption({required Map<String, dynamic> options}) {
    final bool isLogout = options['isDestructive'] == true;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 253, 252, 252),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            options['icon'],
            color: isLogout ? Colors.red : Color.fromARGB(255, 14, 77, 150),
          ),
        ),
        title: Text(
          options['title'],
          style: GoogleFonts.openSans(
            color: isLogout ? Colors.red : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          options['subtitle'],
          style: GoogleFonts.openSans(
            color: Colors.grey[800],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: isLogout ? Colors.red : Colors.black,
          size: 16,
        ),
        onTap: options['onTap'],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onPressed,
      {Color? color}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: IconButton(
        icon: Icon(icon, color: color ?? Colors.black, size: 24),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        onPressed: onPressed,
      ),
    );
  }
}

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
              ),
              child: TextFormField(
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
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const CircularProgressIndicator(),
            ),
          );
        },
      );

      // Simulate API call with delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context); // Remove loading indicator

        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF1872db),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 16,
          duration: const Duration(seconds: 3),
        );

        // Direct navigation to MyAccountPage
        Future.delayed(const Duration(seconds: 1), () {
          Get.off(() => MyAccountPage());
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      appBar: CustomStaticAppBar(
        title: 'Edit Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Color.fromARGB(255, 4, 4, 4)),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save form data
                Get.back();
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 249, 249, 249), Color.fromARGB(255, 135, 206, 235), Color.fromARGB(255, 135, 206, 235)],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 32),
              _buildFormSection('Personal Information', [
                _buildTextField('Full Name', Icons.person_outline),
                _buildTextField('Phone Number', Icons.phone_outlined),
                _buildTextField('Email Address', Icons.email_outlined),
              ]),
              _buildDivider(),
              _buildFormSection('Academic Details', [
                _buildTextField('College/University', Icons.school_outlined),
                _buildTextField('Degree', Icons.history_edu),
              ]),
              const SizedBox(height: 32),
              _buildSubmitButton(),
            ],
          ),
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
                'Save Changes',
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

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomStaticAppBar(
        title: 'Settings',
      ),
      body: Center(
        child: Text(
          'Settings Page',
          style: GoogleFonts.openSans(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}
