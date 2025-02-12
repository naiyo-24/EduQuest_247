import 'package:eduquest247/components/app_bar_dropdown.dart';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:eduquest247/components/standard_app_bar.dart';

class PostJobsPage extends StatelessWidget {
  const PostJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight =
        kToolbarHeight * 0.8; // Adjusted for StandardAppBar height
    final availableHeight =
        screenHeight - appBarHeight - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: const StandardAppBar(color: Color.fromARGB(255, 255, 254, 254),),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildFormContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            'Create New Job Post',
            style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: [Colors.black87, Colors.black54],
                ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Fill in the details below',
            style: GoogleFonts.openSans(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 135, 206, 235), // Changed form box background color
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            _buildFormFields(),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildStyledInputField(
            'Company Name',
            Icons.business,
            hint: 'Enter company name',
          ),
          _buildStyledInputField(
            'Job Title',
            Icons.work,
            hint: 'Enter job title',
          ),
          _buildStyledInputField(
            'Location',
            Icons.location_on,
            hint: 'Enter job location',
          ),
          _buildStyledInputField(
            'Salary Range',
            Icons.attach_money,
            hint: 'Enter salary range',
          ),
          _buildStyledInputField(
            'Experience Required',
            Icons.timeline,
            hint: 'Enter required experience',
          ),
          _buildStyledMultilineField(
            'Job Description',
            Icons.description,
            hint: 'Enter detailed job description',
          ),
          _buildStyledMultilineField(
            'Requirements',
            Icons.list,
            hint: 'Enter job requirements',
          ),
        ],
      ),
    );
  }

  Widget _buildStyledInputField(String label, IconData icon, {String? hint}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Changed text color to black
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.openSans(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                prefixIcon: Icon(icon, color: Colors.black, size: 20), // Changed icon color to black
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledMultilineField(String label, IconData icon,
      {String? hint}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Changed text color to black
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.openSans(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12),
                  child: Icon(icon, color: Colors.black, size: 20), // Changed icon color to black
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 135, 206, 235),
        border: Border(top: BorderSide(color: Color.fromARGB(255, 135, 206, 235)!)),
      ),
      child: ElevatedButton(
        onPressed: () => _handleSubmit(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'Post Job',
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    // Show loading indicator
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

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); // Remove loading indicator

      // Show success message
      Get.snackbar(
        'Success',
        'Job posted successfully',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(255, 15, 99, 195),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Show posted jobs bottom sheet
      Future.delayed(const Duration(milliseconds: 20), () {
        _showMyPosts(context);
      });
    });
  }

  void _showMyPosts(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 135, 206, 235), // Changed footer color
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Posted Jobs',
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                        // Show new form after closing
                        Future.delayed(const Duration(milliseconds: 30), () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PostJobsPage(),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  itemCount: _myPostedJobs.length,
                  itemBuilder: (context, index) =>
                      _buildJobCard(_myPostedJobs[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobCard(Map<String, String> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          job['title']!,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              job['company']!,
              style: GoogleFonts.openSans(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              job['salary']!,
              style: GoogleFonts.openSans(
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: Text('Edit', style: GoogleFonts.openSans()),
              ),
              onTap: () {
                // Handle edit
              },
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text('Delete',
                    style: GoogleFonts.openSans(color: Colors.red)),
              ),
              onTap: () {
                // Handle delete
              },
            ),
          ],
        ),
      ),
    );
  }

  // Sample data for posted jobs
  static final List<Map<String, String>> _myPostedJobs = [
    {
      'title': 'Senior Flutter Developer',
      'company': 'Tech Solutions Inc.',
      'salary': '\$80,000 - \$100,000',
    },
    {
      'title': 'UI/UX Designer',
      'company': 'Creative Studios',
      'salary': '\$60,000 - \$75,000',
    },
    {
      'title': 'Project Manager',
      'company': 'Global Systems',
      'salary': '\$90,000 - \$120,000',
    },
  ];
}
