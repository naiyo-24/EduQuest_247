import 'package:eduquest247/chat_boat.dart';
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
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      title: Text(title, style: GoogleFonts.poppins(color: Colors.white)),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



void main() async {
  // Add this line before your app starts
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
      backgroundColor: const Color.fromARGB(255, 135, 206, 235), // Sky blue color
      appBar: CustomStaticAppBar(
        title: 'My Profile',
        actions: [
          _buildActionIcon(
            Icons.arrow_back_ios_new_rounded,
            () => Get.back(),
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
            colors: [Colors.white, Color.fromARGB(255, 135, 206, 235), Color.fromARGB(255, 135, 206, 235)],
          ),
        ),
        child: ListView(
          children: [
            // Add Profile Picture Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.jpeg', // Local asset image path
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.black,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Rajdeep Dey', // Replace with actual user name
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'deyrajdeep201@gmail.com', // Replace with actual user email
                    style: GoogleFonts.poppins(
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
                color: Colors.white,
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
                      'icon': Icons.settings_outlined,
                      'title': 'Settings',
                      'subtitle': 'App preferences and more',
                      'onTap': () => Get.to(() =>
                          const StylishPage()), // Changed from Navigator.pushNamed
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatbotScreen()),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.chat, color: Colors.white),
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
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
            color: isLogout ? Colors.red : Colors.black,
          ),
        ),
        title: Text(
          options['title'],
          style: GoogleFonts.poppins(
            color: isLogout ? Colors.red : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          options['subtitle'],
          style: GoogleFonts.poppins(
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

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomStaticAppBar(
        title: 'Edit Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
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
            colors: [Colors.white, Color.fromARGB(255, 0, 0, 0), Colors.black],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildFormField(
                label: 'Full Name',
                icon: Icons.person,
                initialValue: 'John Doe',
              ),
              _buildFormField(
                label: 'Phone Number',
                icon: Icons.phone,
                initialValue: '+1 234 567 890',
                keyboardType: TextInputType.phone,
              ),
              _buildFormField(
                label: 'Email',
                icon: Icons.email,
                initialValue: 'john.doe@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              _buildFormField(
                label: 'Password',
                icon: Icons.lock,
                isPassword: true,
                initialValue: '********',
              ),
              _buildFormField(
                label: 'College',
                icon: Icons.school,
                initialValue: 'University Name',
              ),
              _buildFormField(
                label: 'Degree',
                icon: Icons.history_edu,
                initialValue: 'Bachelor of Technology',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required String initialValue,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
