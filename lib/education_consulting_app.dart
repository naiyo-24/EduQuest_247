import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EducationConsultingApp extends StatelessWidget {
  const EducationConsultingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduQuest247'),
        backgroundColor: const Color(0xFF333333), // Charcoal Gray
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              _buildGreetingSection(),
              const SizedBox(height: 16),
              // Quick Actions
              _buildQuickActions(context),
              const SizedBox(height: 16),
              // Progress Tracker
              _buildProgressTracker(),
              const SizedBox(height: 16),
              // Featured Updates
              _buildFeaturedUpdates(),
              const SizedBox(height: 16),
              // Internship Finder
              _buildInternshipFinder(context),
              const SizedBox(height: 16),
              // Loan Assistance
              _buildLoanAssistance(context),
              const SizedBox(height: 16),
              // Career Guidance
              _buildCareerGuidance(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/profile.jpg'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi [Name],',
              style: GoogleFonts.openSans(
                color: const Color(0xFF333333), // Charcoal Gray
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Ready to achieve your goals today?',
              style: GoogleFonts.openSans(
                color: const Color(0xFF333333), // Charcoal Gray
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildQuickAccessWidget(
          context,
          'Find Internships',
          Icons.work_outline,
          const Color(0xFF008080), // Teal
          '/internships',
        ),
        _buildQuickAccessWidget(
          context,
          'Apply for Loans',
          Icons.monetization_on, // Icon for Loan Assistance
          const Color(0xFFFFA500), // Soft Orange
          '/loan_assistance', // Updated route
        ),
        _buildQuickAccessWidget(
          context,
          'Get Career Guidance',
          Icons.school,
          const Color(0xFF6A0DAD), // Vivid Purple
          '/career_guidance', // Updated route
        ),
      ],
    );
  }

  Widget _buildQuickAccessWidget(BuildContext context, String title,
      IconData icon, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(route);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTracker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: GoogleFonts.openSans(
            color: const Color(0xFF333333), // Charcoal Gray
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 0.7, // Example progress value
          backgroundColor: Colors.grey[300],
          color: const Color(0xFF008080), // Teal
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildFeaturedUpdates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Updates',
          style: GoogleFonts.openSans(
            color: const Color(0xFF333333), // Charcoal Gray
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Add your scrolling banners here
      ],
    );
  }

  Widget _buildInternshipFinder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Internship Finder',
          style: GoogleFonts.openSans(
            color: const Color(0xFF333333), // Charcoal Gray
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Add your internship finder widgets here
      ],
    );
  }

  Widget _buildLoanAssistance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loan Assistance',
          style: GoogleFonts.openSans(
            color: const Color(0xFF333333), // Charcoal Gray
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Add your loan assistance widgets here
      ],
    );
  }

  Widget _buildCareerGuidance(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Career Guidance',
          style: GoogleFonts.openSans(
            color: const Color(0xFF333333), // Charcoal Gray
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Add your career guidance widgets here
      ],
    );
  }
}
