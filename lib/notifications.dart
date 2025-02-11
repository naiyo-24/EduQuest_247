// ignore_for_file: unused_import

import 'package:eduquest247/components/app_bar_dropdown.dart';
import 'package:eduquest247/components/floating_nav_button.dart';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:eduquest247/components/standard_app_bar.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight * 0.8;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - appBarHeight - statusBarHeight;

    return Scaffold(
      appBar: const StandardAppBar(color: Color.fromARGB(255, 255, 255, 255),),
      body: Container(
        height: availableHeight,
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
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.fromLTRB(16, 8, 16, 16), // Adjusted padding
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == 0) return _buildPriorityNotification();
                    if (index == 1) return _buildNewNotification();
                    return _buildRegularNotification();
                  },
                  childCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: IconButton(
        icon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0), size: 24),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPriorityNotification() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white, // Changed from black
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.1), // Changed to dark background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.campaign,
                      color: Colors.black, size: 24), // Changed to black
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Important Update!',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your loan application has been approved',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '2 minutes ago',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewNotification() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white, // Changed from black
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1), // Changed background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.work_outline,
                    color: Colors.black, // Changed to black
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Internship Available',
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 106, 105, 105)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Software Development at Tech Corp',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '1 hour ago',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegularNotification() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white, // Changed from black
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1), // Changed background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.black, // Changed to black
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Regular Update',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(
                              255, 0, 0, 0), // Changed from Color(0xFF333333)
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Check out our latest features and updates',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.7), // Changed from grey
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '2 days ago',
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 5, 5, 5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
