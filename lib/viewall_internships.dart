// ignore_for_file: unused_import

import 'dart:ui';

import 'package:eduquest247/components/app_bar_dropdown.dart';
import 'package:eduquest247/components/floating_nav_button.dart';
import 'package:eduquest247/pages/home_screen.dart';
import 'package:eduquest247/route/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: 
import 'internships/web_dev.dart';
import 'internships/network_market.dart';
import 'internships/graphics_design.dart';
import 'internships/app_dev.dart';
import 'internships/dig_market.dart';
import 'package:eduquest247/components/standard_app_bar.dart';

// Main function to run the app
void main() {
  runApp(EduQuestApp());
}

// Main app widget
class EduQuestApp extends StatelessWidget {
  const EduQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internships',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 251, 251, 251),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
      ),
      home: ViewAllInternshipsPage(),
    );
  }
}

class ViewAllInternshipsPage extends StatelessWidget {
  final List<Map<String, String>> internshipOptions = [
    {"title": "Web Development", "page": Routes.webdev},
    {"title": "Network Marketing", "page": Routes.network},
    {"title": "Graphics Designing", "page": Routes.graphics},
    {"title": "App Development", "page": Routes.appdev},
    {"title": "Digital Marketing", "page": Routes.digmarket},
  ];

  ViewAllInternshipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(
          () => HomeScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 30),
        );
        return false;
      },
      child: Scaffold(
        appBar: const StandardAppBar(color: Color.fromARGB(255, 255, 255, 255),),
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
                          'Available Internship Programs',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: internshipOptions.length,
                          itemBuilder: (context, index) {
                            final internship = internshipOptions[index];
                            return _buildInternshipBox(
                              internship["title"]!,
                              internship["page"]!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const FloatingNavButton(currentIndex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildInternshipBox(String title, String page) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(page),
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
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'View Details',
                          style: GoogleFonts.poppins(
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
